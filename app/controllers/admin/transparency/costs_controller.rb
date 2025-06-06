class Admin::Transparency::CostsController < Admin::ApplicationController
  load_and_authorize_resource :year, 
                              class: 'Transparency::Year',
                              id_param: :year_id
  load_and_authorize_resource class: 'Transparency::Cost'

  def show
    breadcrumb
    add_breadcrumb @cost
  end

  def new
    breadcrumb
    add_breadcrumb t('ui.transparency.costs.add')
  end

  def edit
    breadcrumb
    add_breadcrumb t('edit')
  end

  def create
    @cost.transparency_year_id = params[:year_id]
    if @cost.save
      redirect_to admin_transparency_year_cost_path(year_id: @cost.year.id, id: @cost),
                  notice: t('admin.successfully_created_html', model: @cost.to_s)
    else
      breadcrumb
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @cost.update(cost_params)
      redirect_to admin_transparency_year_cost_path(year_id: @cost.year.id, id: @cost),
                  notice: t('admin.successfully_updated_html', model: @cost.to_s)
    else
      breadcrumb
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @cost.destroy!
    redirect_to admin_transparency_year_url(@year),
                notice: t('admin.successfully_destroyed_html', model: @cost.to_s)
  end

  protected

  def breadcrumb
    super
    add_breadcrumb t('ui.transparency.title'), admin_transparency_years_path
    add_breadcrumb @year, admin_transparency_year_path(@year)
  end

  def cost_params
    params.require(:transparency_cost).permit(:title, :description, :amount)
  end
end
