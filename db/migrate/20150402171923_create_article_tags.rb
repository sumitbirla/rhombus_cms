class CreateArticleTags < ActiveRecord::Migration
  def change
    create_table :cms_article_tags do |t|
      t.references :article, index: true
      t.references :tag, index: true
    end
  end
end
