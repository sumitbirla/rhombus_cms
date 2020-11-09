class Admin::Cms::ListsController < Admin::BaseController

  def index
    authorize List.new
    @lists = List.includes(:items).order("user_id, affiliate_id, name").paginate(page: params[:page], per_page: @per_page)
  end

  def new
    @list = authorize List.new
    add_items(@list, 5)

    render 'edit'
  end

  def create
    @list = authorize List.new(list_params)

    unless params[:add_more_items].blank?
      count = params[:add_more_items].to_i - @list.items.length + 5
      count.times { @list.items.build(priority: 1) }
      return render 'edit'
    end

    if @list.save
      redirect_to action: 'index', notice: 'List was successfully created.'
    else
      add_items(@list, 5)
      render 'edit'
    end
  end

  def edit
    @list = authorize List.find(params[:id])
    add_items(@list, 5)
  end

  def update
    @list = authorize List.find(params[:id])
    item_count = @list.items.length

    @list.assign_attributes(list_params)

    unless params[:add_more_items].blank?
      count = params[:add_more_items].to_i - item_count + 5
      add_items(@list, count)

      return render 'edit'
    end

    if @list.save
      redirect_to action: 'index', notice: 'List was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @list = authorize List.find(params[:id])
    @list.destroy

    flash[:success] = 'List has been deleted.'
    redirect_back(fallback_location: admin_root_path)
  end


  private

  def list_params
    params.require(:list).permit!
  end

  def add_items(list, count)
    max_item = list.items.max_by(&:priority)
    priority = max_item ? max_item.priority : 0

    count.times do
      priority += 1
      list.items.build(priority: priority)
    end
  end

end
