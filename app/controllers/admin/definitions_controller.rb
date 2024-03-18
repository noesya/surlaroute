class Admin::DefinitionsController < Admin::ApplicationController

  load_and_authorize_resource

  def index
    @definitions = @definitions.autofilter(params[:filters]).ordered.page(params[:page])
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
    if @definition.save
      redirect_to [:admin, @definition], notice: t('admin.successfully_created_html', model: @definition)
    else
      breadcrumb
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @definition.update(definition_params)
      redirect_to [:admin, @definition], notice: t('admin.successfully_updated_html', model: @definition)
    else
      breadcrumb
      add_breadcrumb t('edit')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @definition.destroy
    redirect_to admin_definitions_url, notice: t('admin.successfully_destroyed_html', model: @definition)
  end

  protected

  def breadcrumb
    add_breadcrumb Definition.model_name.human(count: 2), admin_definitions_path
    if @definition
      if @definition.persisted?
        add_breadcrumb @definition, [:admin, @definition]
      else
        add_breadcrumb t('create')
      end
    end
  end

  def definition_params
    params.require(:definition)
          .permit(
            :title, :text, aliases_attributes: [:id, :title, :_destroy]
          )
  end

end