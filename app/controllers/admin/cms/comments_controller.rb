class Admin::Cms::CommentsController < Admin::BaseController

  def index
    @comments = Comment.order("created_at DESC").page(params[:page])
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
