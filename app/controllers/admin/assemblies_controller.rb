class Admin::AssembliesController < Admin::ApplicationController
  load_and_authorize_resource find_by: :slug

  include Admin::Filterable

  def index
    @assemblies = @assemblies.autofilter(params[:filters]).ordered.page(params[:page])
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
    if @assembly.save
      redirect_to [:admin, @assembly], notice: t('admin.successfully_created_html', model: @assembly.to_s)
    else
      breadcrumb
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @assembly.update(assembly_params)
      redirect_to [:admin, @assembly], notice: t('admin.successfully_updated_html', model: @assembly.to_s)
    else
      breadcrumb
      add_breadcrumb t('edit')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @assembly.destroy
    redirect_to admin_assemblies_url, notice: t('admin.successfully_destroyed_html', model: @assembly.to_s)
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Assembly.model_name.human(count: 2), admin_assemblies_path
    breadcrumb_for @assembly
  end

  def assembly_params
    params.require(:assembly)
          .permit(
            :name, :slug, :description,
            :image, :image_delete, :image_infos,
            :published, :published_by_id,
            structure_values_attributes: [:id, :item_id, :text, :option_ids, :file, :file_delete, :_destroy, option_ids: []]
          )
  end
end
