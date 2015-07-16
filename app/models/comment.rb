# == Schema Information
#
# Table name: cms_comments
#
#  id               :integer          not null, primary key
#  commentable_id   :integer          not null
#  commentable_type :string(255)      not null
#  parent_id        :integer
#  user_id          :integer
#  author           :string(255)
#  email            :string(255)
#  url              :string(255)
#  content          :text(65535)      not null
#  rating           :integer          default(0), not null
#  approved         :boolean          not null
#  spam             :boolean          not null
#  ip_address       :string(255)      not null
#  user_agent       :string(255)      not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Comment < ActiveRecord::Base
  self.table_name = 'cms_comments'
  
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  
  has_many :replies, class_name: "Comment", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Comment"
end
