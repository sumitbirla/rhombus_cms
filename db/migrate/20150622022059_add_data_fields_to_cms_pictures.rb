class AddDataFieldsToCmsPictures < ActiveRecord::Migration
  def change
    add_column :cms_pictures, :data1, :string
    add_column :cms_pictures, :data2, :string
  end
end
