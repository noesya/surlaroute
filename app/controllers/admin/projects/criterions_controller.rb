class Admin::Projects::CriterionsController < Admin::ApplicationController
  load_and_authorize_resource class: Project::Criterion

  def new
    breadcrumb
    add_breadcrumb 'Ajouter un critère'
  end

  def edit
    breadcrumb
    add_breadcrumb @criterion
  end

  def reorder
    authorize!(:reorder, Project::Criterion)
    ids = params[:ids] || []
    ids.each.with_index do |id, index|
      criterion = Project::Criterion.find(id)
      criterion.update_column :position, index + 1
    end
  end

  def create
    if @criterion.save
      redirect_to redirect_path, notice: t('admin.successfully_created_html', model: @criterion.to_s)
    else
      breadcrumb
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @criterion.update(criterion_params)
      redirect_to redirect_path, notice: t('admin.successfully_updated_html', model: @criterion.to_s)
    else
      breadcrumb
      add_breadcrumb t('edit')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @criterion.destroy
    redirect_to redirect_path, notice: t('admin.successfully_destroyed_html', model: @criterion.to_s)
  end

  protected

  def redirect_path
    admin_structure_items_path(about_class: 'Project')
  end

  def breadcrumb
    super
    add_breadcrumb Structure.model_name.human(count: 2)
    add_breadcrumb Project.model_name.human(count: 2), admin_structure_items_path(about_class: 'Project')
  end

  def criterion_params
    params.require(:project_criterion)
          .permit(
            :name, :if_you_check, :hint, :step
          )
  end
end
