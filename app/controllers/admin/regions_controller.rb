class Admin::RegionsController < Admin::ApplicationController
  load_and_authorize_resource find_by: :slug

  def index
    @regions = @regions.ordered.page(params[:page])
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
    if @region.save
      redirect_to [:admin, @region], notice: t('admin.successfully_created_html', model: @region.to_s)
    else
      breadcrumb
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @region.update(region_params)
      redirect_to [:admin, @region], notice: t('admin.successfully_updated_html', model: @region.to_s)
    else
      breadcrumb
      add_breadcrumb t('edit')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @region.destroy
    redirect_to admin_regions_url, notice: t('admin.successfully_destroyed_html', model: @region.to_s)
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Region.model_name.human(count: 2), admin_regions_path
    breadcrumb_for @region
  end

  def region_params
    params.require(:region)
          .permit(:name, :slug, :description)
  end
end
