class Admin::ActorsController < Admin::ApplicationController
  load_and_authorize_resource find_by: :slug

  include Admin::ResourceWithStructure

  def index
    params[:order_by] ||= 'date:desc'
    @actors = @actors.autofilter(params[:filters]).order_by(params[:order_by]).page(params[:page])
    breadcrumb
  end

  def show
    @logs = @actor.logs.ordered.page(params[:page])
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
    @actor.authors << current_user if cannot?(:publish, @actor)
    if @actor.save
      redirect_to [:edit, :admin, @actor], notice: t('admin.successfully_created_html', model: @actor.to_s)
    else
      breadcrumb
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @actor.update(actor_params)
      redirect_to [:edit, :admin, @actor], notice: t('admin.successfully_updated_html', model: @actor.to_s)
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
    add_breadcrumb t('ecosystem'), admin_actors_path
    breadcrumb_for @actor
  end

  def actor_params
    allowed_params = [
      :name, :slug, :description, :sources,
      :image, :image_delete, :image_infos, :image_alt, :image_credit,
      :logo, :logo_delete,
      :service_access_terms, :address, :address_additional, :zipcode, :city, :country,
      :contact_name, :contact_email, :contact_phone, :contact_website, :contact_inventory_url,
      project_ids: [], material_ids: [],
      region_ids: [],
      structure_values_attributes: structure_values_permitted_attributes
    ]
    allowed_params += [:published, :status, author_ids: []] if can?(:publish, Actor)
    allowed_params << :premium if can?(:premium, Actor)
    allowed_params << :lab_member if can?(:lab_member, Actor)
    params.require(:actor)
          .permit(allowed_params)
  end
end
