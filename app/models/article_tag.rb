# == Schema Information
#
# Table name: cms_article_tags
#
#  id         :integer          not null, primary key
#  article_id :integer
#  tag_id     :integer
#

class ArticleTag < ActiveRecord::Base
  self.table_name = "cms_article_tags"
  
  belongs_to :article
  belongs_to :tag
end
