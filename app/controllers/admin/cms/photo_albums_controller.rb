class Admin::Cms::PhotoAlbumsController < Admin::BaseController
  
  def index
    authorize PhotoAlbum.new
    @photo_albums = PhotoAlbum.order(:title)
    
    respond_to do |format|
      format.html  { @photo_albums = @photo_albums.paginate(page: params[:page], per_page: @per_page) }
      format.csv { send_data PhotoAlbum.to_csv(@photo_albums) }
    end
  end

  def new
    @photo_album = authorize PhotoAlbum.new(title: 'New photo album')
    render 'edit'
  end

  def create
    @photo_album = authorize PhotoAlbum.new(photo_album_params)
    
    if @photo_album.save
      redirect_to action: 'index', notice: 'Photo Album was successfully created.'
    else
      render 'edit'
    end
  end

  def show
    @photo_album = authorize PhotoAlbum.find(params[:id])
  end

  def edit
    @photo_album = authorize PhotoAlbum.find(params[:id])
  end

  def update
    @photo_album = authorize PhotoAlbum.find(params[:id])
    
    if @photo_album.update(photo_album_params)
      redirect_to action: 'index', notice: 'Photo Album was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @photo_album = authorize PhotoAlbum.find(params[:id])
    @photo_album.destroy
    redirect_to action: 'index', notice: 'Photo Album has been deleted.'
  end
  
  
  private
  
    def photo_album_params
      params.require(:photo_album).permit!
    end
  
end
