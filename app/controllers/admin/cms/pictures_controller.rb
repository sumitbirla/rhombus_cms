class Admin::Cms::PicturesController < Admin::BaseController

  def index
    authorize Picture.new
    @pictures = Picture.order(created_at: :desc)

    if params[:imageable_type] && params[:imageable_id]
      case params[:imageable_type]
      when 'photoalbum'
        @parent = PhotoAlbum.find(params[:imageable_id])
      end

      @pictures = @pictures.where(imageable_id: params[:imageable_id], imageable_type: params[:imageable_type])
    end

    respond_to do |format|
      format.html { @pictures = @pictures.paginate(page: params[:page], per_page: @per_page) }
      format.csv { send_data Picture.to_csv(@pictures) }
    end

  end

  def new
    @picture = authorize Picture.new(imageable_type: params[:imageable_type], imageable_id: params[:imageable_id], user_id: session[:user_id])
    render 'edit'
  end


  def create
    pic = authorize Picture.new(picture_params)

    base_dir = Cache.setting(Rails.configuration.domain_id, :system, "Static Files Path")
    pic.set_picture_properties(base_dir)

    # determine sort 
    pic.sort = Picture.where(imageable_type: pic.imageable_type, imageable_id: pic.imageable_id).maximum(:sort)
    pic.sort = 0 if pic.sort.nil?
    pic.sort = pic.sort + 1
    pic.save

    return redirect_to params[:redirect] unless params[:redirect].nil?

    redirect_to action: 'index', imageable_id: pic.imageable_id, imageable_type: pic.imageable_type
  end


  def edit
    @picture = authorize Picture.find(params[:id])
  end


  def update
    base_dir = Cache.setting(Rails.configuration.domain_id, :system, "Static Files Path")
    @picture = authorize Picture.find(params[:id])
    @picture.set_picture_properties(base_dir)

    if @picture.width.blank?
      @picture.errors.add(:base, "Image doesn't appear to be in valid format.")
      return render "edit"
    end

    if @picture.update(picture_params)
      flash[:notice] = 'Picture was successfully updated.'
      redirect_to action: 'index', imageable_id: @picture.imageable_id, imageable_type: @picture.imageable_type
    else
      render 'edit'
    end
  end


  def destroy
    @picture = authorize Picture.find(params[:id])
    @picture.destroy
    redirect_back(fallback_location: admin_root_path)
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

    redirect_back(fallback_location: admin_root_path)

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

    redirect_back(fallback_location: admin_root_path)

  end


  private

  def picture_params
    params.require(:picture).permit!
  end


end
