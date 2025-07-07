class Admin::Tours::ShowsController < Admin::ApplicationController
  load_and_authorize_resource class: Tour::Show

  load_and_authorize_resource :tour, 
                              class: Tour,
                              find_by: :slug

  include Admin::ResourceWithStructure

  def show
    @logs = @show.logs.ordered.page(params[:page])
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
    @show.tour = @tour
    if @show.save
      redirect_to admin_tour_path(@tour), notice: t('admin.successfully_created_html', model: @show.to_s)
    else
      breadcrumb
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @show.update(show_params)
      redirect_to admin_tour_path(@tour), notice: t('admin.successfully_updated_html', model: @show.to_s)
    else
      breadcrumb
      add_breadcrumb t('edit')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @show.destroy!
    redirect_to admin_tour_url(@tour), notice: t('admin.successfully_destroyed_html', model: @show.to_s)
  end


  protected

  def breadcrumb
    super
    add_breadcrumb Tour.model_name.human(count: 2), admin_tours_path
    breadcrumb_for @tour
    if @show.persisted?
      add_breadcrumb @show, admin_tour_show_path(tour_id: @tour, id: @show)
    else
      add_breadcrumb t('create')
    end
  end

  def show_params
    allowed_params = [
      :day, :place_id, :title,
      region_ids: [],
      structure_values_attributes: structure_values_permitted_attributes
    ]
    allowed_params += [:published, :status, author_ids: []] if can?(:publish, Tour)
    params.require(:tour_show)
          .permit(allowed_params)
  end
end
