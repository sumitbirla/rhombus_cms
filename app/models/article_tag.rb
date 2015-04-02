class ArticleTag < ActiveRecord::Base
  self.table_name = "cms_article_tags"
  
  belongs_to :article
  belongs_to :tag
end
