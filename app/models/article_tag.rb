# == Schema Information
#
# Table name: cms_article_tags
#
#  id         :integer          not null, primary key
#  article_id :integer
#  tag_id     :integer
#
# Indexes
#
#  index_cms_article_tags_on_article_id  (article_id)
#  index_cms_article_tags_on_tag_id      (tag_id)
#

class ArticleTag < ActiveRecord::Base
  self.table_name = "cms_article_tags"

  belongs_to :article
  belongs_to :tag
end
