class Admin::CriterionsController < Admin::ApplicationController
  load_and_authorize_resource

  include Admin::Filterable

  def index
    @criterions = apply_scopes(@criterions).ordered.page(params[:page])
    breadcrumb
  end

  def show
    breadcrumb
  end

  def new
    @criterion = Criterion.new
    breadcrumb
  end

  def edit
    breadcrumb
    add_breadcrumb t('edit')
  end

  def create
    @criterion = Criterion.new(criterion_params)
    if @criterion.save
      redirect_to [:admin, @criterion], notice: t('admin.successfully_created_html', model: @criterion.to_s)
    else
      breadcrumb
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @criterion.update(criterion_params)
      redirect_to [:admin, @criterion], notice: t('admin.successfully_updated_html', model: @criterion.to_s)
    else
      breadcrumb
      add_breadcrumb t('edit')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @criterion.destroy!
    redirect_to admin_criterions_url, notice: t('admin.successfully_destroyed_html', model: @criterion.to_s)
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Criterion.model_name.human(count: 2), admin_criterions_path
    breadcrumb_for @criterion
  end

  def criterion_params
    params.require(:criterion).permit(:name, :kind, :hint, :about_class, :position)
  end
end
