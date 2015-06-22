class PicturesController < ApplicationController
  layout "single_column"
  
  def new
    @picture = Picture.new
  end
  
  def show
    @picture = Picture.find_by(id: params[:id], approved: true)
    @photo_album = PhotoAlbum.find(@picture.imageable_id)
    
    @next = Picture.where("created_at < ?", @picture.created_at).where(approved: true, imageable_type: :photoalbum, imageable_id: @photo_album.id).order(created_at: :desc).first
    @previous = Picture.where("created_at > ?", @picture.created_at).where(approved: true, imageable_type: :photoalbum, imageable_id: @photo_album.id).order(created_at: :desc).first
  end
  
end
