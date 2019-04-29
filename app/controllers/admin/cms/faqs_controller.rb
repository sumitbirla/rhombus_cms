class Admin::Cms::FaqsController < Admin::BaseController
  
  def index
    authorize Faq.new
    @faqs = Faq.where(domain_id: cookies[:domain_id]).order(:sort)
    
    respond_to do |format|
      format.html  { @faqs = @faqs.paginate(page: params[:page], per_page: @per_page) }
      format.csv { send_data Faq.to_csv(@faqs) }
    end
  end

  def new
    @faq = authorize Faq.new
    render 'edit'
  end

  def create
    @faq = authorize Faq.new(faq_params)
    @faq.domain_id = cookies[:domain_id]
    
    if @faq.save
      redirect_to action: 'index', notice: 'Faq was successfully created.'
    else
      render 'edit'
    end
  end

  def edit
    @faq = authorize Faq.find(params[:id])
  end

  def update
    @faq = authorize Faq.find(params[:id])
    
    if @faq.update(faq_params)
      Rails.cache.delete @faq
      redirect_to action: 'index', notice: 'Faq was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @faq = authorize Faq.find(params[:id])
    @faq.destroy
    
    Rails.cache.delete @faq
    redirect_back(fallback_location: admin_root_path), notice: 'Faq has been deleted.'
  end
  
  
  private
  
    def faq_params
      params.require(:faq).permit!
    end
  
end
