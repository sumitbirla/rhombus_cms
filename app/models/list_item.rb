# == Schema Information
#
# Table name: cms_list_items
#
#  id               :bigint           not null, primary key
#  background_color :string(255)
#  foreground_color :string(255)
#  priority         :integer
#  value            :text(65535)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  list_id          :integer          not null
#
class ListItem < ApplicationRecord
  self.table_name = "cms_list_items"
  belongs_to :list

  def to_s
    value
  end
end
