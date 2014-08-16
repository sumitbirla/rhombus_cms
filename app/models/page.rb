# == Schema Information
#
# Table name: pages
#
#  id             :integer          not null, primary key
#  title          :string(255)      not null
#  slug           :string(255)      not null
#  published      :boolean          not null
#  header_content :text
#  body           :text             not null
#  created_at     :datetime
#  updated_at     :datetime
#

class Page < ActiveRecord::Base
  self.table_name = 'cms_pages'
  
  validates_presence_of :title, :slug, :published, :body
  validates_uniqueness_of :slug
  
  def cache_key
    "page:#{slug}"
  end
end
