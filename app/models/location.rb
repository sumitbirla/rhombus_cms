# == Schema Information
#
# Table name: locations
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  slug           :string(255)      not null
#  street1        :string(255)
#  street2        :string(255)
#  city           :string(255)
#  state          :string(255)
#  zip            :string(255)
#  country        :string(255)
#  latitude       :decimal(10, 7)
#  longitude      :decimal(10, 7)
#  hidden         :boolean          not null
#  user_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#  region_id      :integer
#  affiliate_id   :integer
#  contact_person :string(255)
#  phone          :string(255)
#  fax            :string(255)
#  email          :string(255)
#  website        :string(255)
#  summary        :text
#  description    :text
#

class Location < ActiveRecord::Base
  self.table_name = 'cms_locations'
  
  belongs_to :user
  belongs_to :affiliate
  belongs_to :region
  has_many :pictures, as: :imageable
  has_many :location_attributes
  has_many :location_categories
  has_many :categories, through: :location_categories
  has_many :sublocations
  
  validates_presence_of :name, :slug
  validates_uniqueness_of :slug
  
  def to_map
    address = street1
    address = address + ', ' + street2 unless street2.blank?
    address = address + ', ' + city unless city.blank?
    address = address + ', ' + state unless state.blank?
    address = address + ', ' + zip unless zip.blank?
    address = address + ', ' + country unless country.blank?
  end
  
  def to_text
    address = contact_person + "\n" + street1
    address = address + "\n" + street2 unless street2.blank?
    address = address + "\n" + city unless city.blank?
    address = address + ', ' + state unless state.blank?
    address = address + ', ' + zip unless zip.blank?
    address = address + "\n" + country unless country.blank?
  end
  
  def cache_key
    "location:#{slug}"
  end
end
