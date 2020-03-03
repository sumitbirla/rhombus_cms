class CreateListItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cms_list_items do |t|
      t.integer :list_id, null: false
      t.text :value
      t.string :background_color
      t.string :foreground_color
      t.integer :priority

      t.timestamps
    end
  end
end
