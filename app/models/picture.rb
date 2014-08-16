# == Schema Information
#
# Table name: pictures
#
#  id             :integer          not null, primary key
#  imageable_id   :integer
#  imageable_type :string(255)
#  user_id        :integer
#  sort           :integer
#  votes          :integer
#  file_path      :string(255)
#  width          :integer
#  height         :integer
#  file_size      :integer
#  mime_type      :string(255)
#  caption        :text
#  description    :text
#  created_at     :datetime
#  updated_at     :datetime
#

class Picture < ActiveRecord::Base
  self.table_name = 'cms_pictures'
  
  belongs_to :imageable, polymorphic: true
  belongs_to :user
  has_many :comments, as: :commentable
  #has_many :votes, as: :votable
  
  validates_presence_of :imageable_id, :imageable_type, :file_path
  
  def cache_key
    "picture:#{id}"
  end
end
