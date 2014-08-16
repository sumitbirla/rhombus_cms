# == Schema Information
#
# Table name: sublocations
#
#  id          :integer          not null, primary key
#  location_id :integer
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Sublocation < ActiveRecord::Base
  self.table_name = 'cms_sublocations'
  belongs_to :location
  validates_presence_of :location_id, :name
end