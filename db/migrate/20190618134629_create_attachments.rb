class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :cms_attachments do |t|
      t.references :attachable, polymorphic: true
      t.string :file_path, null: false
      t.string :mime_type, null: false
      t.text :metadata

      t.timestamps
    end
  end
end
