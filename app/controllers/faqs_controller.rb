class FaqsController < ApplicationController

  def index
    @faqs = CmsCache.faqs
  end

  def category

  end

end
