# == Schema Information
#
# Table name: regions
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  slug        :string(255)
#  default     :boolean
#  enabled     :boolean
#  hidden      :boolean
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Region < ActiveRecord::Base
  self.table_name = 'cms_regions'
  validates_uniqueness_of :slug, :name
  
  def to_s
    name
  end
end
