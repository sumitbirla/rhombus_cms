# == Schema Information
#
# Table name: cms_articles
#
#  id             :integer          not null, primary key
#  domain_id      :integer          not null
#  user_id        :integer
#  status         :string(255)      not null
#  slug           :string(255)      not null
#  published_at   :date
#  allow_pings    :boolean          default(FALSE), not null
#  allow_comments :boolean          default(FALSE), not null
#  title          :string(255)      not null
#  author         :string(255)      not null
#  body           :text(65535)      not null
#  excerpt        :text(65535)      not null
#  keywords       :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Article < ActiveRecord::Base
  self.table_name = "cms_articles"
  
  belongs_to :user
  has_many :article_tags
  has_many :tags, through: :article_tags
  has_many :pictures, -> { order :sort }, as: :imageable
  has_many :comments, as: :commentable
  has_many :article_categories
  has_many :categories, -> { order :sort }, through: :article_categories
  
  validates_presence_of :title, :author, :excerpt, :body, :slug
  validates_uniqueness_of :slug
  
  def cache_key
    "article:#{domain_id}:#{slug}"
  end
  
  def save_tags(tags)
    existing_tags = Tag.where(name: tags)
    ArticleTag.where(article_id: id).delete_all
    
    tags.each do |tag|
      next if tag.blank?
      
      et = existing_tags.find { |x| x.name == tag }
      et = Tag.create(name: tag) if et.nil?
      ArticleTag.create(article_id: id, tag_id: et.id)
    end
  end
  
end
