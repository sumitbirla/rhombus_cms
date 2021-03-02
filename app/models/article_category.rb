# == Schema Information
#
# Table name: cms_article_categories
#
#  id          :integer          not null, primary key
#  article_id  :integer
#  category_id :integer
#
# Indexes
#
#  index_cms_article_categories_on_article_id   (article_id)
#  index_cms_article_categories_on_category_id  (category_id)
#

class ArticleCategory < ActiveRecord::Base
  self.table_name = "cms_article_categories"

  belongs_to :article
  belongs_to :category
end
