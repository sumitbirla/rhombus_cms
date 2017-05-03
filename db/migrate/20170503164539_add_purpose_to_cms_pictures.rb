class AddPurposeToCmsPictures < ActiveRecord::Migration
  def change
    add_column :cms_pictures, :purpose, :string, null: false, default: 'web'
  end
end
