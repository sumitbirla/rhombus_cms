class CreateMenuItem < ActiveRecord::Migration
  def change
    create_table :cms_menu_items do |t|
      t.references :menu, index: true
      t.string :title, null: false
      t.string :link_url, null: false
      t.integer :sort, null: false
      t.boolean :enabled, null: false, default: true
	  t.timestamps
    end
  end
end
