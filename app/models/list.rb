class List < ApplicationRecord
  self.table_name = "cms_lists"

  belongs_to :user
  belongs_to :affiliate
  has_many :items, class_name: "ListItem", dependent: :destroy

  validates_presence_of :name
end
