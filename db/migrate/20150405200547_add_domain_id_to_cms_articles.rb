class AddDomainIdToCmsArticles < ActiveRecord::Migration
  def change
    add_reference :cms_articles, :domain, index: true
  end
end
