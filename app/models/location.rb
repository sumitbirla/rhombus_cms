# == Schema Information
#
# Table name: cms_locations
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
#  default        :boolean          default("0"), not null
#  region_id      :integer
#  affiliate_id   :integer
#  contact_person :string(255)
#  phone          :string(255)
#  fax            :string(255)
#  email          :string(255)
#  website        :string(255)
#  summary        :text(65535)
#  description    :text(65535)
#  created_at     :datetime
#  updated_at     :datetime
#

class Location < ActiveRecord::Base
  self.table_name = 'cms_locations'
  
  belongs_to :user
  belongs_to :affiliate
  has_many :pictures, as: :imageable
  has_many :extra_properties
  has_many :location_categories
  has_many :categories, through: :location_categories
  has_many :sublocations
  
  validates_presence_of :name, :slug
  validates_uniqueness_of :slug
  
  def to_map
    address = street1
    address += ', ' + street2 unless street2.blank?
    address += ', ' + city unless city.blank?
    address += ', ' + state unless state.blank?
    address += ', ' + zip unless zip.blank?
    address += ', ' + country unless country.blank?
  end
  
  def to_text(opts = {})
    newline = opts[:new_line] || "\n"
    
    address = street1
    address += newline + street2 unless street2.blank?
    address += newline + city unless city.blank?
    address += ', ' + state unless state.blank?
    address += ', ' + zip unless zip.blank?
    unless opts[:skip_country]
      address += newline + Country[country].to_s unless country.blank?
    end
    
    address.html_safe
  end
  
  def cache_key
    "location:#{slug}"
  end
end
