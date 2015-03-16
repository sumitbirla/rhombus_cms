class AddDomainIdToCmsPages < ActiveRecord::Migration
  def change
    add_column :cms_pages, :domain_id, :integer, after: :id, null: false
    add_column :cms_menus, :domain_id, :integer, after: :id, null: false
    add_column :cms_content_blocks, :domain_id, :integer, after: :id, null: false
  end
end
