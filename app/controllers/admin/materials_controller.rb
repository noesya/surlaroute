class Admin::MaterialsController < Admin::ApplicationController
  load_and_authorize_resource find_by: :slug

  include Admin::Filterable

  def index
    @materials = @materials.autofilter(params[:filters]).ordered.page(params[:page])
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
    if @material.save
      redirect_to [:admin, @material], notice: t('admin.successfully_created_html', model: @material.to_s)
    else
      breadcrumb
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @material.update(material_params)
      redirect_to [:admin, @material], notice: t('admin.successfully_updated_html', model: @material.to_s)
    else
      breadcrumb
      add_breadcrumb t('edit')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @material.destroy
    redirect_to admin_materials_url, notice: t('admin.successfully_destroyed_html', model: @material.to_s)
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Material.model_name.human(count: 2), admin_materials_path
    breadcrumb_for @material
  end

  def material_params
    params.require(:material)
          .permit(
            :name, :slug, :description, :actor_id,
            :image, :image_delete, :image_infos, 
            :published_by_id,
            actor_ids: [], project_ids: [],
            region_ids: []
          )
          .merge({ items: params[:material][:items].to_unsafe_hash})
  end
end
