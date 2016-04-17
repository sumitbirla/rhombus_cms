# == Schema Information
#
# Table name: cms_location_attributes
#
#  id           :integer          not null, primary key
#  location_id  :integer          not null
#  attribute_id :integer          not null
#  value        :text(65535)
#  created_at   :datetime
#  updated_at   :datetime
#

class LocationAttribute < ActiveRecord::Base
  self.table_name = 'cms_location_attributes'
  
  belongs_to :location
  belongs_to :core_attribute, class_name: "Attribute", foreign_key: 'attribute_id'
  
  def to_s
    value
  end
end
