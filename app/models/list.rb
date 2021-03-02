# == Schema Information
#
# Table name: cms_lists
#
#  id           :bigint           not null, primary key
#  name         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  affiliate_id :integer
#  user_id      :integer
#
class List < ApplicationRecord
  self.table_name = "cms_lists"

  belongs_to :user
  belongs_to :affiliate
  has_many :items, class_name: "ListItem", dependent: :destroy
  accepts_nested_attributes_for :items, reject_if: lambda { |x| x['value'].blank? }, allow_destroy: true

  validates_presence_of :name

  def to_s
    name
  end

  # PUNDIT
  def self.policy_class
    ApplicationPolicy
  end
end
