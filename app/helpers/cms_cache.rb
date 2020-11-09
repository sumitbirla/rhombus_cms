module CmsCache

  def self.page(slug)
    Rails.cache.fetch("page:#{Rails.configuration.domain_id}:#{slug}") do
      p = Page.where(domain_id: Rails.configuration.domain_id, slug: slug, published: true).first
      ContentBlock.where(domain_id: Rails.configuration.domain_id).each { |cb| p.body = p.body.gsub("\[\[#{cb.key}\]\]", cb.content) }
      p
    end
  end

  def self.article(slug)
    Rails.cache.fetch("article:#{Rails.configuration.domain_id}:#{slug}") do
      Article.includes(:pictures, :categories).find_by(slug: slug, status: "published")
    end
  end

  def self.article_list
    Rails.cache.fetch("article-list") do
      Article.includes(:pictures).where(status: "published").order(published_at: :desc)
    end
  end

  def self.recent_articles
    Rails.cache.fetch("recent-articles", expires_in: 1.hour) do
      Article.includes(:pictures).where(status: "published").order(published_at: :desc).limit(3).load
    end
  end

  def self.content_block(key)
    Rails.cache.fetch("content-block:#{Rails.configuration.domain_id}:#{key}") do
      ContentBlock.find_by(domain_id: Rails.configuration.domain_id, key: key)
    end
  end

  def self.menu(key)
    Rails.cache.fetch("menu:#{Rails.configuration.domain_id}:#{key}") do
      Menu.includes(:items).find_by(domain_id: Rails.configuration.domain_id, key: key)
    end
  end

  def self.location_list(category_slug)
    Rails.cache.fetch("location-list-#{category_slug}") do
      cat = Category.find_by(slug: category_slug, entity_type: :location)
      Location.where(id: LocationCategory.select(:location_id).where(category_id: cat.id)).load
    end
  end

  def self.faqs
    Rails.cache.fetch("faq:#{Rails.configuration.domain_id}") do
      Faq.where(domain_id: Rails.configuration.domain_id).order(:sort)
    end
  end

end