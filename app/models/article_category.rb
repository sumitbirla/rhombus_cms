class ArticleCategory < ActiveRecord::Base
  self.table_name = "cms_article_categories"
  
  belongs_to :article
  belongs_to :category
end
