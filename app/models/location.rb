# == Schema Information
#
# Table name: cms_locations
#
#  id             :integer          not null, primary key
#  city           :string(255)
#  contact_person :string(255)
#  country        :string(255)
#  default        :boolean          default(FALSE), not null
#  description    :text(65535)
#  email          :string(255)
#  fax            :string(255)
#  hidden         :boolean          default(FALSE), not null
#  latitude       :decimal(10, 7)
#  longitude      :decimal(10, 7)
#  name           :string(255)      not null
#  phone          :string(255)
#  slug           :string(255)      default("")
#  state          :string(255)
#  street1        :string(255)
#  street2        :string(255)
#  summary        :text(65535)
#  website        :string(255)
#  zip            :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  affiliate_id   :integer
#  external_id    :string(255)
#  user_id        :integer
#
# Indexes
#
#  index_locations_on_affiliate_id  (affiliate_id)
#

class Location < ActiveRecord::Base
  include Exportable
  acts_as_taggable_on :tags
  self.table_name = 'cms_locations'

  belongs_to :user
  belongs_to :affiliate
  has_many :pictures, as: :imageable
  has_many :extra_properties, -> { order "sort, name" }, as: :extra_property

  validates_presence_of :name
  validates :slug, presence: true, if: -> { slug.present? }

  def to_map
    address = street1
    address += ', ' + street2 unless street2.blank?
    address += ', ' + city unless city.blank?
    address += ', ' + state unless state.blank?
    address += ', ' + zip unless zip.blank?
    address += ', ' + country unless country.blank?
    address
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

  # PUNDIT
  def self.policy_class
    ApplicationPolicy
  end
end
