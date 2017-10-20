class Admin::Cms::CommentsController < Admin::BaseController

  def index
    authorize Comment
    @comments = Comment.order(created_at: :desc)
    
    respond_to do |format|
      format.html  { @comments = @comments.paginate(page: params[:page], per_page: @per_page) }
      format.csv { send_data Comment.to_csv(@comments) }
    end
  end

  def new
    @comment = authorize Menu.new
    render 'edit'
  end

  def create
    @comment = authorize Comment.new(comment_params)
    @comment.assign_attributes(
      ip_address: request.ip,
      user_agent: request.user_agent,
      author: current_user.name,
      email: current_user.email,
      user_id: current_user.id)
    
    # check whether this is spam
    Akismet.api_key =  Cache.setting(Rails.configuration.domain_id, :cms, "Akismet API Key")
    Akismet.app_url = Cache.setting(Rails.configuration.domain_id, :system, "Website URL")
    
    params = {
      type: 'comment',
      text: @comment.content,
      created_at: DateTime.now,
      author: @comment.author,
      author_email: @comment.email,
      post_url: request.url,
      referrer: request.referrer
    }
    
    @comment.spam = Akismet.spam?(request.ip, request.user_agent, params)
    if @comment.spam
      flash[:notice] = "Your comment will be posted after it is approved."
      @comment.approved = false
    end
    
    @comment.save
    redirect_to action: "index"
  end


  def edit
    @comment = authorize Comment.find(params[:id])
  end

  def update
    @comment = authorize Comment.find(params[:id])
    
    if @comment.update(comment_params)
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  def destroy
    @comment = authorize Comment.find(params[:id])
    @comment.destroy
    
    redirect_to :back, notice: 'Comment has been deleted.'
  end
  
  
  private
  
    def comment_params
      params.require(:comment).permit!
    end
    
end
