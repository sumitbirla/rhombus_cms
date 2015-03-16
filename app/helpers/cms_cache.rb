module CmsCache

  def self.page(slug) 
    Rails.cache.fetch("page:#{Rails.configuration.domain_id}:#{slug}") do 
      p = Page.where(domain_id: Rails.configuration.domain_id, slug: slug, published: true).first
      ContentBlock.where(domain_id: Rails.configuration.domain_id).each { |cb| p.body = p.body.gsub("\[\[#{cb.key}\]\]", cb.content) }
      p
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

end