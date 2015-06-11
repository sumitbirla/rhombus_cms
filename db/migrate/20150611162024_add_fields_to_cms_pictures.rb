class AddFieldsToCmsPictures < ActiveRecord::Migration
  def change
    rename_column :cms_pictures, :mime_type, :format
    add_column :cms_pictures, :bits_per_pixel, :integer
    add_column :cms_pictures, :chroma_subsampling, :string
    add_column :cms_pictures, :compression_mode, :string
  end
end
