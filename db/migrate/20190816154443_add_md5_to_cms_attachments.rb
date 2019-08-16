class AddMd5ToCmsAttachments < ActiveRecord::Migration[5.2]
  def change
    add_column :cms_attachments, :md5, :string, after: :metadata
  end
end
