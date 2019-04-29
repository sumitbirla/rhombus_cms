class Account::LocationsController < Account::BaseController

  def index
    @locations = Location.where(user_id: session[:user_id]).order('created_at DESC')
  end

  def new
    @location = Location.new name: 'New location'
    render 'edit'
  end

  def create
    @location = Location.new(location_params)
    @location.slug = SecureRandom.hex(5)
    @location.user_id = current_user.id
    @location.hidden = true

    if @location.save
      Location.where("user_id = ? AND id != ?", session[:user_id], @location.id).update_all(default:false) if @location.default
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  def edit
    @location = Location.find_by(id: params[:id], user_id: session[:user_id])
  end

  def update
    @location = Location.find_by(id: params[:id], user_id: session[:user_id])

    if @location.update(location_params)
      Location.where("user_id = ? AND id != ?", session[:user_id], @location.id).update_all(default:false) if @location.default
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  def destroy
    @location = Location.find_by(id: params[:id], user_id: session[:user_id])
    @location.destroy
    redirect_to action: 'index'
  end


  def primary
    Location.where(user_id: session[:user_id]).update_all(default: false)
    Location.where(user_id: session[:user_id], id: params[:id]).update_all(default: true)

    return redirect_back(fallback_location: account_root_path)
  end


  private

  def location_params
    params.require(:location).permit(:default, :name, :street1, :street2, :city, :state, :zip, :country, :contact_person, :phone)
  end

end