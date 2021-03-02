require 'akismet'

class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.ip_address = request.ip
    @comment.user_agent = request.user_agent
    @comment.approved = true

    unless current_user.nil?
      @comment.author = current_user.name
      @comment.email = current_user.email
      @comment.user_id = current_user.id
    end

    # check whether this is spam
    #Akismet.api_key = Cache.setting(Rails.configuration.domain_id, :cms, "Akismet API Key")
    #Akismet.app_url = Cache.setting(Rails.configuration.domain_id, :system, "Website URL")

    params = {
        type: 'comment',
        text: @comment.content,
        created_at: DateTime.now,
        author: @comment.author,
        author_email: @comment.email,
        post_url: request.url,
        referrer: request.referrer
    }

    #@comment.spam = Akismet.spam?(request.ip, request.user_agent, params)
    #if @comment.spam
    #  flash[:notice] = "Your comment will be posted after it is approved."
    #  @comment.approved = false
    #end

    @comment.save
    return redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :content, :rating, :parent_id)
  end

end
