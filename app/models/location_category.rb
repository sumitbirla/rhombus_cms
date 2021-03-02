# == Schema Information
#
# Table name: cms_location_categories
#
#  id          :integer          not null, primary key
#  category_id :integer          not null
#  location_id :integer          not null
#
# Indexes
#
#  index_location_categories_on_category_id  (category_id)
#  index_location_categories_on_location_id  (location_id)
#

class LocationCategory < ActiveRecord::Base
  self.table_name = 'cms_location_categories'

  belongs_to :location
  belongs_to :category
end
