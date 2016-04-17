class Admin::Cms::LocationsController < Admin::BaseController
  
  def index
    @locations = Location.page(params[:page]).order('name')
    @locations = @locations.where("name LIKE '%#{params[:q]}%'") unless params[:q].nil?
    
    unless params[:c].blank?
      @category = Category.find_by(slug: params[:c], entity_type: :location)
      @locations = @locations.joins(:location_categories).where("cms_location_categories.category_id = ?", @category.id)
    end 
  end

  def new
    @location = Location.new name: 'New location'
    render 'edit'
  end

  def create
    @location = Location.new(location_params)
    
    if @location.save
      redirect_to action: 'show', id: @location.id, notice: 'Location was successfully created.'
    else
      render 'edit'
    end
  end

  def show
    @location = Location.find(params[:id])
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    
    if @location.update(location_params)
      redirect_to action: 'show', id: @location.id, notice: 'Location was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    redirect_to action: 'index', notice: 'Location has been deleted.'
  end
  
  
  def pictures
    @location = Location.find(params[:id])
  end
  
  def categories
    @location = Location.includes(:categories).find(params[:id])
  end
  
  def create_categories
    LocationCategory.delete_all location_id: params[:id]
    category_ids = params[:category_ids]
    
    category_ids.each do |id|
      LocationCategory.create location_id: params[:id], category_id: id
    end
    
    redirect_to action: 'show', id: params[:id], notice: 'Location was successfully updated.'
  end
  
  def attributes
    @location = Location.find(params[:id])
  end
  
  def sublocations
    @location = Location.find(params[:id])
  end
  
  def create_attributes
    
    @location = Location.find(params[:id])
    attr_list = Attribute.where(entity_type: :location)
    
    attr_list.each do |attr|
      
      loc_attr = @location.location_attributes.find { |a| a.attribute_id == attr.id }
      attr_id = "attr-#{attr.id}"
      
      # DELETE
      if params[attr_id].blank?  
        loc_attr.destroy if loc_attr
        next
      end
      
      #ADD
      unless loc_attr
        loc_attr = LocationAttribute.new location_id: @location.id, attribute_id: attr.id
      end
      
      loc_attr.value = params[attr_id]
      loc_attr.save
      
    end
    
    redirect_to action: 'show', id: params[:id], notice: 'Location was successfully updated.'
  end
  
  
  def formatted
    @location = Location.find(params[:id])
    render text: @location.to_text
  end
  
  
  private
  
    def location_params
      params.require(:location).permit!
    end
  
end
