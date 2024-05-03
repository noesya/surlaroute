class Admin::ProjectsController < Admin::ApplicationController
  load_and_authorize_resource find_by: :slug

  include Admin::ResourceWithStructure

  def index
    params[:order_by] ||= 'date:desc'
    @projects = @projects.autofilter(params[:filters]).order_by(params[:order_by]).page(params[:page])
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
    @project.authors << current_user if cannot?(:publish, @project)
    if @project.save
      redirect_to [:edit, :admin, @project], notice: t('admin.successfully_created_html', model: @project.to_s)
    else
      breadcrumb
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      redirect_to [:edit, :admin, @project], notice: t('admin.successfully_updated_html', model: @project.to_s)
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
    allowed_params = [
      :name, :slug, :description,
      :image, :image_delete, :image_infos, :image_alt, :image_credit,
      :acceptance,
      actor_ids: [], material_ids: [], technic_ids: [],
      region_ids: [],
      answers_attributes: [:id, :criterion_id, :value, :text],
      structure_values_attributes: structure_values_permitted_attributes
    ]
    allowed_params += [:published, :status, author_ids: []] if can?(:publish, Project)
    params.require(:project)
          .permit(allowed_params)
  end
end
