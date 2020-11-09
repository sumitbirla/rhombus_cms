class PagesController < ApplicationController

  def show
    @page = CmsCache.page(params[:slug])

    if @page.nil?
      flash.now[:error] = "The page you are looking for was not found."
      return render "error_page", status: 404
    end
  end

end
