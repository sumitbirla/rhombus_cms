# == Schema Information
#
# Table name: menus
#
#  id         :integer          not null, primary key
#  key        :string(255)      not null
#  title      :string(255)      not null
#  css_class  :string(255)
#  created_at :datetime
#  updated_at :datetime
#  notes      :text
#

class Menu < ActiveRecord::Base
  self.table_name = 'cms_menus'
  
  has_many :items, -> { order :sort }, class_name: 'MenuItem'
  validates_uniqueness_of :key, scope: :domain_id
  
  def cache_key
    "menu:#{key}"
  end
end
