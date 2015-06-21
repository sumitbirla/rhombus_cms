class AddApprovedToCmsPictures < ActiveRecord::Migration
  def change
    add_column :cms_pictures, :approved, :boolean, null: false, default: true
  end
end
