class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :cms_lists do |t|
      t.integer :user_id
      t.integer :affiliate_id
      t.string :name

      t.timestamps
    end
  end
end
