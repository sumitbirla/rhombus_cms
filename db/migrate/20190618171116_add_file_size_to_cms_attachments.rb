class AddFileSizeToCmsAttachments < ActiveRecord::Migration[5.2]
  def change
    add_column :cms_attachments, :file_size, :integer, after: :file_path
  end
end
