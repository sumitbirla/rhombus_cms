# == Schema Information
#
# Table name: cms_comments
#
#  id               :integer          not null, primary key
#  approved         :boolean          not null
#  author           :string(255)
#  commentable_type :string(255)      not null
#  content          :text(65535)      not null
#  email            :string(255)
#  ip_address       :string(255)      not null
#  rating           :integer          default(0), not null
#  spam             :boolean          not null
#  url              :string(255)
#  user_agent       :string(255)      not null
#  created_at       :datetime
#  updated_at       :datetime
#  commentable_id   :integer          not null
#  parent_id        :integer
#  user_id          :integer
#

class Comment < ActiveRecord::Base
  include Exportable
  self.table_name = 'cms_comments'

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  has_many :replies, class_name: "Comment", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Comment"

  # PUNDIT
  def self.policy_class
    ApplicationPolicy
  end
end
