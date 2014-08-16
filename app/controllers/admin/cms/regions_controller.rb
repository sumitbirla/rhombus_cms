class Admin::Cms::RegionsController < Admin::BaseController
  
  def index
    @regions = Region.page(params[:page]).order('name')
  end

  def new
    @region = Region.new name: 'New region'
    render 'edit'
  end

  def create
    @region = Region.new(region_params)
    
    if @region.save
      
      # Un-default other regions if this one is default
      if @region.default
        Region.where.not(id: @region.id).update_all(default: false)
      end
      
      redirect_to action: 'index', notice: 'Region was successfully created.'
    else
      render 'edit'
    end
  end

  def show
    @region = Region.find(params[:id])
  end

  def edit
    @region = Region.find(params[:id])
  end

  def update
    @region = Region.find(params[:id])
    
    if @region.update(region_params)
      
      # Un-default other regions if this one is default
      if @region.default
        Region.where.not(id: @region.id).update_all(default: false)
      end
      
      redirect_to action: 'index', notice: 'Region was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @region = Region.find(params[:id])
    @region.destroy
    redirect_to action: 'index', notice: 'Region has been deleted.'
  end
  
  
  private
  
    def region_params
      params.require(:region).permit(:name, :slug, :default, :enabled, :hidden, :description)
    end
    
end
