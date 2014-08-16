class Admin::Cms::PhotoAlbumsController < Admin::BaseController
  
  def index
    @photo_albums = PhotoAlbum.page(params[:page]).order('title')
  end

  def new
    @photo_album = PhotoAlbum.new title: 'New photo album'
    render 'edit'
  end

  def create
    @photo_album = PhotoAlbum.new(photo_album_params)
    
    if @photo_album.save
      redirect_to action: 'index', notice: 'Photo Album was successfully created.'
    else
      render 'edit'
    end
  end

  def show
    @photo_album = PhotoAlbum.find(params[:id])
  end

  def edit
    @photo_album = PhotoAlbum.find(params[:id])
  end

  def update
    @photo_album = PhotoAlbum.find(params[:id])
    
    if @photo_album.update(photo_album_params)
      redirect_to action: 'index', notice: 'Photo Album was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @photo_album = PhotoAlbum.find(params[:id])
    @photo_album.destroy
    redirect_to action: 'index', notice: 'Photo Album has been deleted.'
  end
  
  
  private
  
    def photo_album_params
      params.require(:photo_album).permit(:title, :slug, :user_id, :public, :allow_upload, :voting_enabled, :description)
    end
  
end