class CreateArticleCategories < ActiveRecord::Migration
  def change
    create_table :cms_article_categories do |t|
      t.references :article, index: true
      t.references :category, index: true
    end
  end
end
