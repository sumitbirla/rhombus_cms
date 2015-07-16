# == Schema Information
#
# Table name: cms_tags
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
  self.table_name = "cms_tags"
  validates_presence_of :name
  validates_uniqueness_of :name
end
