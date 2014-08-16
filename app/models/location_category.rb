# == Schema Information
#
# Table name: location_categories
#
#  id          :integer          not null, primary key
#  location_id :integer          not null
#  category_id :integer          not null
#

class LocationCategory < ActiveRecord::Base
  self.table_name = 'cms_location_categories'
  
  belongs_to :location
  belongs_to :category
end
