# == Schema Information
#
# Table name: cms_articles
#
#  id             :integer          not null, primary key
#  allow_comments :boolean          default(FALSE), not null
#  allow_pings    :boolean          default(FALSE), not null
#  author         :string(255)      not null
#  body           :text(65535)      not null
#  excerpt        :text(65535)
#  keywords       :string(255)
#  published_at   :date
#  slug           :string(255)      not null
#  status         :string(255)      not null
#  title          :string(255)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  domain_id      :integer          not null
#  user_id        :integer
#
# Indexes
#
#  index_cms_articles_on_domain_id  (domain_id)
#  index_cms_articles_on_user_id    (user_id)
#

class Article < ActiveRecord::Base
  include Exportable
  acts_as_taggable_on :tags
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

  # PUNDIT
  def self.policy_class
    ApplicationPolicy
  end

end
