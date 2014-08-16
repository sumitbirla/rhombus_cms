require 'RMagick'


class Admin::Cms::PicturesController < Admin::BaseController
  
  def index
    
    @pictures = Picture.page(params[:page]).order('created_at DESC')
    
    if params[:imageable_type] && params[:imageable_id]  
      case params[:imageable_type]
      when 'photoalbum'
        @parent = PhotoAlbum.find(params[:imageable_id])
      end
      
      @pictures = @pictures.where(imageable_id: params[:imageable_id], imageable_type: params[:imageable_type])         
    end
    
  end
  
  def new
    @picture = Picture.new imageable_type: params[:imageable_type], imageable_id: params[:imageable_id], caption: 'New picture'
    puts @picture.inspect
    render 'edit'
  end
  
 
  def create
    pic = Picture.new(picture_params)
    
    # update dimensions and file size
    url = Cache.setting('System', 'Static Files Url') + pic.file_path
    img = Magick::Image.read(url).first

	  if img.nil?
      flash[:notice] = 'File does not appear to be a valid image'
      return redirect_to :back
    end

    pic.width = img.columns
    pic.height = img.rows
    pic.file_size = img.filesize
    pic.mime_type = img.mime_type
    
    # determine sort 
    pic.sort = Picture.where(imageable_type: pic.imageable_type, imageable_id: pic.imageable_id).maximum(:sort)
    pic.sort = 0 if pic.sort.nil?
    pic.sort = pic.sort + 1
    pic.save
    
    return redirect_to params[:redirect] unless params[:redirect].nil?
    
    redirect_to action: 'index', imageable_id: pic.imageable_id, imageable_type: pic.imageable_type
  end
  
  
  def edit
    @picture = Picture.find(params[:id])
  end
  

  def update
    @picture = Picture.find(params[:id])
    
    if @picture.update(picture_params)
      
      # update dimensions and file size
      url = Cache.setting('System', 'Static Files Url') + @picture.file_path
	    img = Magick::Image.read(url).first

      if img.nil?
      	flash[:notice] = 'File does not appear to be a valid image'
      	return redirect_to :back
      end

      @picture.update(width: img.columns, height: img.rows, file_size: img.filesize, mime_type: img.mime_type)

      flash[:notice] = 'Picture was successfully updated.'
      redirect_to action: 'index', imageable_id: @picture.imageable_id, imageable_type: @picture.imageable_type
    else
      render 'edit'
    end
  end
  

  def destroy
    Picture.delete(params[:id])
    redirect_to :back
  end
  
  
  def moveup
    
    pic1 = Picture.find(params[:id])
    list = Picture.where(imageable_type: pic1.imageable_type, imageable_id: pic1.imageable_id).order(:sort)
    pic2 = list[list.index(pic1) - 1]
    
    temp_sort = pic1.sort
    pic1.sort = pic2.sort
    pic2.sort = temp_sort
    
    pic1.save
    pic2.save
  
    redirect_to :back
    
  end
  
  
  def movedown
    
    pic1 = Picture.find(params[:id])
    list = Picture.where(imageable_type: pic1.imageable_type, imageable_id: pic1.imageable_id).order(:sort)
    pic2 = list[list.index(pic1) + 1]
    
    temp_sort = pic1.sort
    pic1.sort = pic2.sort
    pic2.sort = temp_sort
    
    pic1.save
    pic2.save
  
    redirect_to :back
    
  end
  
  
  private
  
    def picture_params
      params.require(:picture).permit(:imageable_id, :imageable_type, :user_id, :sort, :votes, :file_path, :width, :height, 
      :file_size, :mime_type, :caption, :description)
    end
  
  
end
