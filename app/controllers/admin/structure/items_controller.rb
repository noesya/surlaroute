class Admin::Structure::ItemsController < Admin::ApplicationController
  load_and_authorize_resource class: Structure::Item

  include Admin::Filterable

  def index
    @items = apply_scopes(@items).ordered.page(params[:page])
    breadcrumb
  end

  def show
    breadcrumb
  end

  def new
    @item = Structure::Item.new
    breadcrumb
  end

  def edit
    breadcrumb
    add_breadcrumb t('edit')
  end

  def create
    @item = Structure::Item.new(item_params)
    if @item.save
      redirect_to [:admin, @item], notice: t('admin.successfully_created_html', model: @item.to_s)
    else
      breadcrumb
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      redirect_to [:admin, @item], notice: t('admin.successfully_updated_html', model: @item.to_s)
    else
      breadcrumb
      add_breadcrumb t('edit')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy!
    redirect_to admin_items_url, notice: t('admin.successfully_destroyed_html', model: @item.to_s)
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Structure.model_name.human(count: 2)
    breadcrumb_for @item
  end

  def item_params
    params.require(:item).permit(:name, :kind, :hint, :about_class, :position)
  end
end
