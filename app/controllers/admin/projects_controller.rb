class Admin::ProjectsController < Admin::ApplicationController
  load_and_authorize_resource find_by: :slug

  include Admin::Filterable

  def index
    @projects = @projects.autofilter(params[:filters]).ordered.page(params[:page])
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
    if @project.save
      redirect_to [:admin, @project], notice: t('admin.successfully_created_html', model: @project.to_s)
    else
      breadcrumb
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      redirect_to [:admin, @project], notice: t('admin.successfully_updated_html', model: @project.to_s)
    else
      breadcrumb
      add_breadcrumb t('edit')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to admin_projects_url, notice: t('admin.successfully_destroyed_html', model: @project.to_s)
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Project.model_name.human(count: 2), admin_projects_path
    breadcrumb_for @project
  end

  def project_params
    params.require(:project)
          .permit(
            :name, :slug, :description,
            :image, :image_delete, :image_infos,
            :published, :published_by_id,
            actor_ids: [], material_ids: [],
            region_ids: [],
            structure_values_attributes: [:id, :item_id, :text, :option_id, :file, :file_delete, :_destroy]
          )
  end
end
