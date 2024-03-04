class Admin::ActorsController < Admin::ApplicationController
  load_and_authorize_resource find_by: :slug

  include Admin::ResourceWithStructure

  def index
    @actors = @actors.autofilter(params[:filters]).ordered.page(params[:page])
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
    if @actor.save
      redirect_to [:admin, @actor], notice: t('admin.successfully_created_html', model: @actor.to_s)
    else
      breadcrumb
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @actor.update(actor_params)
      redirect_to [:admin, @actor], notice: t('admin.successfully_updated_html', model: @actor.to_s)
    else
      breadcrumb
      add_breadcrumb t('edit')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @actor.destroy
    redirect_to admin_actors_url, notice: t('admin.successfully_destroyed_html', model: @actor.to_s)
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Actor.model_name.human(count: 2), admin_actors_path
    breadcrumb_for @actor
  end

  def actor_params
    allowed_params = [
      :name, :slug, :description,
      :image, :image_delete, :image_infos, :image_alt, :image_credit,
      :service_access_terms, :address, :address_additional, :zipcode, :city, :country,
      :contact_name, :contact_email, :contact_phone, :contact_website, :contact_inventory_url,
      project_ids: [], material_ids: [],
      region_ids: [],
      structure_values_attributes: structure_values_permitted_attributes
    ]
    allowed_params += [:published, :published_by_id] if can?(:publish, Actor)
    allowed_params << :premium if can?(:premium, Actor)
    params.require(:actor)
          .permit(allowed_params)
  end
end
