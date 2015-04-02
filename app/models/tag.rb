class Tag < ActiveRecord::Base
  self.table_name = "cms_tags"
  validates_presence_of :name
  validates_uniqueness_of :name
end
