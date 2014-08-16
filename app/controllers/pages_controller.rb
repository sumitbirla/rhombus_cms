class PagesController < ApplicationController
  
  def show
    @page = Cache.page(params[:slug])
    render text: '404 Page Not Found', status: 404 if @page.nil?
  end
  
end
