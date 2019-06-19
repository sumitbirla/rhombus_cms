class AddFileNameToCmsAttachment < ActiveRecord::Migration[5.2]
  def change
    add_column :cms_attachments, :file_name, :string, after: :attachable_id
  end
end
