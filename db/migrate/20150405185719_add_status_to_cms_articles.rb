class AddStatusToCmsArticles < ActiveRecord::Migration
  def change
    add_column :cms_articles, :status, :string, null: false
	remove_column :cms_articles, :published
	change_column :cms_articles, :published_at, :date
  end
end
