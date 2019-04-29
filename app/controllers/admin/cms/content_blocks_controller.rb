class Admin::Cms::ContentBlocksController < Admin::BaseController
  
  def index
    authorize ContentBlock.new
    @content_blocks = ContentBlock.where(domain_id: cookies[:domain_id]).order(:key)
    
    respond_to do |format|
      format.html  { @content_blocks = @content_blocks.paginate(page: params[:page], per_page: @per_page) }
      format.csv { send_data ContentBlock.to_csv(@content_blocks) }
    end
  end

  def new
    @content_block = authorize ContentBlock.new(key: 'new-block')
    render 'edit'
  end

  def create
    @content_block = authorize ContentBlock.new(content_block_params)
    @content_block.domain_id = cookies[:domain_id]
    
    if @content_block.save
      redirect_to action: 'index', notice: 'ContentBlock was successfully created.'
    else
      render 'edit'
    end
  end

  def show
    @content_block = authorize ContentBlock.find(params[:id])
  end

  def edit
    @content_block = authorize ContentBlock.find(params[:id])
  end

  def update
    @content_block = authorize ContentBlock.find(params[:id])
    
    if @content_block.update(content_block_params)
      Rails.cache.delete @content_block
      redirect_to action: 'index', notice: 'Content Block was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @content_block = authorize ContentBlock.find(params[:id])
    @content_block.destroy
    
    Rails.cache.delete @content_block
    redirect_back(fallback_location: admin_root_path), notice: 'Content Block has been deleted.'
  end
  
  
  private
  
    def content_block_params
      params.require(:content_block).permit(:key, :content)
    end
  
end
