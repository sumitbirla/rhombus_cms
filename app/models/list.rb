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
