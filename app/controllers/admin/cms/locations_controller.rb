class Admin::Cms::LocationsController < Admin::BaseController

  def index
    authorize Location.new

    @locations = Location.order('name')
    @locations = @locations.where("name LIKE '%#{params[:q]}%'") unless params[:q].nil?

    unless params[:c].blank?
      @category = Category.find_by(slug: params[:c], entity_type: :location)
      @locations = @locations.joins(:location_categories).where("cms_location_categories.category_id = ?", @category.id)
    end

    respond_to do |format|
      format.html { @locations = @locations.paginate(page: params[:page], per_page: @per_page) }
      format.csv { send_data Location.to_csv(@locations) }
    end
  end

  def new
    @location = authorize Location.new(name: 'New location')
    render 'edit'
  end

  def create
    @location = authorize Location.new(location_params)

    if @location.save
      redirect_to action: 'show', id: @location.id, notice: 'Location was successfully created.'
    else
      render 'edit'
    end
  end

  def show
    @location = authorize Location.find(params[:id])
  end

  def edit
    @location = authorize Location.find(params[:id])
  end

  def update
    @location = authorize Location.find(params[:id])

    if @location.update(location_params)
      redirect_to action: 'show', id: @location.id, notice: 'Location was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @location = authorize Location.find(params[:id])
    @location.destroy
    redirect_to action: 'index', notice: 'Location has been deleted.'
  end


  def pictures
    @location = Location.find(params[:id])
    authorize @location, :show?
  end

  def categories
    @location = Location.includes(:categories).find(params[:id])
    authorize @location, :show?
  end

  def create_categories
    authorize Location, :update?

    LocationCategory.delete_all location_id: params[:id]
    category_ids = params[:category_ids]

    category_ids.each do |id|
      LocationCategory.create location_id: params[:id], category_id: id
    end

    redirect_to action: 'show', id: params[:id], notice: 'Location was successfully updated.'
  end

  def extra_properties
    @location = Location.find(params[:id])
    authorize @location, :show?
    5.times { @location.extra_properties.build }
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
