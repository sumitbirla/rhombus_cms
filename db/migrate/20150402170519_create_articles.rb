class CreateArticles < ActiveRecord::Migration
  def change
    create_table :cms_articles do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.text :body, null: false
      t.text :excerpt, null: false
      t.string :keywords
      t.references :user, index: true
      t.string :slug, null: false
      t.boolean :allow_pings, null: false, default: false
      t.boolean :allow_comments, null: false, default: false
      t.datetime :published_at
      t.boolean :published, null: false, default: false

      t.timestamps null: false
    end
  end
end
