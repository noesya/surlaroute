class Admin::TechnicsController < Admin::ApplicationController
  load_and_authorize_resource find_by: :slug

  include Admin::ResourceWithStructure

  def index
    params[:order_by] ||= 'date:desc'
    @technics = @technics.autofilter(params[:filters]).order_by(params[:order_by]).page(params[:page])
    breadcrumb
  end

  def show
    @logs = @technic.logs.ordered.page(params[:page])
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
    @technic.authors << current_user if cannot?(:publish, @technic)
    if @technic.save
      redirect_to [:edit, :admin, @technic], notice: t('admin.successfully_created_html', model: @technic.to_s)
    else
      breadcrumb
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @technic.update(technic_params)
      redirect_to [:edit, :admin, @technic], notice: t('admin.successfully_updated_html', model: @technic.to_s)
    else
      breadcrumb
      add_breadcrumb t('edit')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @technic.destroy
    redirect_to admin_technics_url, notice: t('admin.successfully_destroyed_html', model: @technic.to_s)
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Technic.model_name.human(count: 2), admin_technics_path
    breadcrumb_for @technic
  end

  def technic_params
    allowed_params = [
      :name, :slug, :description,
      :image, :image_delete, :image_infos, :image_alt, :image_credit,
      actor_ids: [], region_ids: [],
      structure_values_attributes: structure_values_permitted_attributes
    ]
    allowed_params += [:published, :status, author_ids: []] if can?(:publish, Technic)
    params.require(:technic)
          .permit(allowed_params)
  end
end
