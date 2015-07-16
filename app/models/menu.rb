# == Schema Information
#
# Table name: cms_menus
#
#  id         :integer          not null, primary key
#  domain_id  :integer          not null
#  key        :string(255)      not null
#  title      :string(255)      not null
#  css_class  :string(255)
#  created_at :datetime
#  updated_at :datetime
#  notes      :text(65535)
#

class Menu < ActiveRecord::Base
  self.table_name = 'cms_menus'
  
  has_many :items, -> { order :sort }, class_name: 'MenuItem'
  validates_uniqueness_of :key, scope: :domain_id
  
  def cache_key
    "menu:#{domain_id}:#{key}"
  end
end
