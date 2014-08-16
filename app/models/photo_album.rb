# == Schema Information
#
# Table name: photo_albums
#
#  id             :integer          not null, primary key
#  slug           :string(255)      not null
#  user_id        :integer
#  public         :boolean          not null
#  allow_upload   :boolean          not null
#  voting_enabled :boolean          not null
#  title          :string(255)      not null
#  description    :text
#  created_at     :datetime
#  updated_at     :datetime
#

class PhotoAlbum < ActiveRecord::Base
  self.table_name = 'cms_photo_albums'
  
  has_many :pictures, as: :imageable
  belongs_to :user
  validates_uniqueness_of :slug
  
  def cache_key
    "photo-album:#{slug}"
  end
  
  def to_s
    title
  end
  
end
