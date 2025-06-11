class Admin::ToursController < Admin::ApplicationController
  load_and_authorize_resource find_by: :slug

  include Admin::ResourceWithStructure

  def index
    params[:order_by] ||= 'date:desc'
    @tours = @tours.autofilter(params[:filters]).order_by(params[:order_by]).page(params[:page])
    breadcrumb
  end

  def show
    @logs = @tour.logs.ordered.page(params[:page])
    @shows = @tour.shows.ordered
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
    @tour.authors << current_user if cannot?(:publish, @tour)
    @tour = Tour.new(tour_params)
    if @tour.save
      redirect_to [:edit, :admin, @tour], notice: t('admin.successfully_created_html', model: @tour.to_s)
    else
      breadcrumb
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @tour.update(tour_params)
      redirect_to [:edit, :admin, @tour], notice: t('admin.successfully_updated_html', model: @tour.to_s)
    else 
      breadcrumb
      add_breadcrumb t('edit')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tour.destroy!
    redirect_to admin_tours_url, notice: t('admin.successfully_destroyed_html', model: @tour.to_s)
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Tour.model_name.human(count: 2), admin_tours_path
    breadcrumb_for @tour
  end

  def tour_params
    allowed_params = [
      :name, :slug, :description, :year, :website,
      :image, :image_delete, :image_infos, :image_alt, :image_credit,
      region_ids: [],
      structure_values_attributes: structure_values_permitted_attributes
    ]
    allowed_params += [:published, :status, author_ids: []] if can?(:publish, Tour)
    params.require(:tour)
          .permit(allowed_params)
  end
end
