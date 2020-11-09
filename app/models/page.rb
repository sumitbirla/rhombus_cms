# == Schema Information
#
# Table name: cms_pages
#
#  id             :integer          not null, primary key
#  domain_id      :integer          not null
#  title          :string(255)      not null
#  slug           :string(255)      not null
#  published      :boolean          not null
#  header_content :text(65535)
#  body           :text(65535)      not null
#  created_at     :datetime
#  updated_at     :datetime
#

class Page < ActiveRecord::Base
  include Exportable
  self.table_name = 'cms_pages'

  validates_presence_of :title, :slug, :published, :body
  validates_uniqueness_of :slug, scope: :domain_id

  def cache_key
    "page:#{domain_id}:#{slug}"
  end

  # PUNDIT
  def self.policy_class
    ApplicationPolicy
  end
end
