class Article < ActiveRecord::Base
  self.table_name = "cms_articles"
  
  belongs_to :user
  has_many :tags
  has_many :pictures, -> { order :sort }, as: :imageable
  has_many :comments, as: :commentable
  has_many :article_categories
  has_many :categories, -> { order :sort }, through: :article_categories
  
  validates_presence_of :title, :author, :excerpt, :body, :slug
  validates_uniqueness_of :slug
end
