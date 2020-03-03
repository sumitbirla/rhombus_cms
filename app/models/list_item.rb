class ListItem < ApplicationRecord
  self.table_name = "cms_list_items"
  belongs_to :list
end
