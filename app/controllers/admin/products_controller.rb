class Admin::ProductsController < Admin::ApplicationController
  load_and_authorize_resource

  def index
    @products = @products.ordered
    breadcrumb
  end

  def show
    breadcrumb
  end

  def new
    breadcrumb
  end

  def edit
    breadcrumb
    add_breadcrumb t('edit')
  end

  def create
    if @product.save
      redirect_to [:admin, @product], notice: t('admin.successfully_created_html', model: @product.to_s)
    else
      breadcrumb
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      redirect_to [:admin, @product], notice: t('admin.successfully_updated_html', model: @product.to_s)
    else
      breadcrumb
      add_breadcrumb t('edit')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_url, notice: t('admin.successfully_destroyed_html', model: @product.to_s)
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Product.model_name.human(count: 2), admin_products_path
    breadcrumb_for @product
  end

  def product_params
    params.require(:product)
          .permit(
            :name, :description, :price
          )
  end
end
