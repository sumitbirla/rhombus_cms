# == Schema Information
#
# Table name: cms_menu_items
#
#  id         :integer          not null, primary key
#  menu_id    :integer          not null
#  title      :string(255)      not null
#  link_url   :string(255)      not null
#  sort       :integer          not null
#  enabled    :boolean          not null
#  created_at :datetime
#  updated_at :datetime
#

class MenuItem < ActiveRecord::Base
  self.table_name = 'cms_menu_items'
  belongs_to :menu
end
