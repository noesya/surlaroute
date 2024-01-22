class Admin::Structure::ItemsController < Admin::Structure::ApplicationController
  load_and_authorize_resource class: Structure::Item, find_by: :slug

  include Admin::Reorderable

  def index
    @items = @items.where(about_class: about_class).ordered
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
    @item.about_class = about_class
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
    add_breadcrumb about_class.constantize.model_name.human(count: 2), admin_structure_items_path(about_class: about_class)
    breadcrumb_for @item
  end

  def item_params
    params.require(:structure_item)
          .permit(
            :name, :slug, :kind, :hint, :with_explanation, :zone, 
            options_attributes: [
              :id, :name, :slug, :position, :_destroy
            ]
          )
  end
end
