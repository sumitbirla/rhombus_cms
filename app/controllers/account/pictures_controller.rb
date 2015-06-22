class Account::PicturesController < Account::BaseController
  skip_before_filter :verify_authenticity_token, only: :upload
  
  def index
    @pictures = Picture.where(user_id: session[:user_id]).order(created_at: :desc).page(params[:page])
  end
  
  
  def create
    @picture = Picture.new(picture_params)
    base_dir = Cache.setting(Rails.configuration.domain_id, :system, "Static Files Path")
    @picture.set_picture_properties(base_dir)
    @picture.save
    
    redirect_to :back
  end
  
  
  # called from DropZone.js
  def upload
    static_files_path = Cache.setting(Rails.configuration.domain_id, :system, "Static Files Path")
    user_dir =  static_files_path + "/userfiles/uploads/#{session[:user_id]}"
    user_dir = "/tmp/"
    Dir.mkdir(user_dir) unless File.exists?(user_dir)

    uploaded_io = params[:file]
    ext = uploaded_io.original_filename.split('.').last
  
    unless uploaded_io.nil? || ['jpg', 'gif'].include?(ext) == false
      file_path = user_dir + SecureRandom.hex(6) + '.' + ext
   
      File.open(file_path, 'wb') do |file|
        file.write(uploaded_io.read)
      end
    
      return render json: { status: 'ok', file_path: file_path.sub(static_files_path, "") }
    end
  
    render json: { status: 'error', message: "Not a valid image file" }
  end
  
  
  private
  
  def picture_params
    params.require(:picture).permit(:caption, :file_path, :data1, :data2, :approved)
  end
  
end
