class Admin::Cms::FaqsController < Admin::BaseController
  
  def index
    @faqs = Faq.where(domain_id: cookies[:domain_id]).page(params[:page]).order(:sort)
  end

  def new
    @faq = Faq.new
    render 'edit'
  end

  def create
    @faq = Faq.new(faq_params)
    @faq.domain_id = cookies[:domain_id]
    
    if @faq.save
      redirect_to action: 'index', notice: 'Faq was successfully created.'
    else
      render 'edit'
    end
  end

  def edit
    @faq = Faq.find(params[:id])
  end

  def update
    @faq = Faq.find(params[:id])
    
    if @faq.update(faq_params)
      Rails.cache.delete @faq
      redirect_to action: 'index', notice: 'Faq was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @faq = Faq.find(params[:id])
    @faq.destroy
    
    Rails.cache.delete @faq
    redirect_to :back, notice: 'Faq has been deleted.'
  end
  
  
  private
  
    def faq_params
      params.require(:faq).permit!
    end
  
end
