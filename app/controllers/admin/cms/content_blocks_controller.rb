class Admin::Cms::ContentBlocksController < Admin::BaseController
  
  def index
    @content_blocks = ContentBlock.order(:key).page(params[:page])
  end

  def new
    @content_block = ContentBlock.new key: 'new-block'
    render 'edit'
  end

  def create
    @content_block = ContentBlock.new(content_block_params)
    
    if @content_block.save
      redirect_to action: 'index', notice: 'ContentBlock was successfully created.'
    else
      render 'edit'
    end
  end

  def show
    @content_block = ContentBlock.find(params[:id])
  end

  def edit
    @content_block = ContentBlock.find(params[:id])
  end

  def update
    @content_block = ContentBlock.find(params[:id])
    
    if @content_block.update(content_block_params)
      Rails.cache.delete @content_block
      redirect_to action: 'index', notice: 'Content Block was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @content_block = ContentBlock.find(params[:id])
    @content_block.destroy
    
    Rails.cache.delete @content_block
    redirect_to :back, notice: 'Content Block has been deleted.'
  end
  
  
  private
  
    def content_block_params
      params.require(:content_block).permit(:key, :content)
    end
  
end
