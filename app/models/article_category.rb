# == Schema Information
#
# Table name: cms_article_categories
#
#  id          :integer          not null, primary key
#  article_id  :integer
#  category_id :integer
#

class ArticleCategory < ActiveRecord::Base
  self.table_name = "cms_article_categories"

  belongs_to :article
  belongs_to :category
end
