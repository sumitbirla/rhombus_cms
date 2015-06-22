class PhotoAlbumsController < ApplicationController
  
  def index
    @photo_albums = PhotoAlbum.where(public: true)
  end
  
  def show
    @photo_album = PhotoAlbum.find_by(slug: params[:slug], public: true)
    @pictures = @photo_album.pictures.where(approved: true).order(created_at: :desc).page(params[:page])
  end
  
end
