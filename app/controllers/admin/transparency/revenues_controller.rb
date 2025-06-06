class Admin::Transparency::RevenuesController < Admin::ApplicationController
  load_and_authorize_resource :year, 
                              class: 'Transparency::Year',
                              id_param: :year_id
  load_and_authorize_resource class: 'Transparency::Revenue'

  def show
    breadcrumb
    add_breadcrumb @revenue
  end

  def new
    breadcrumb
    add_breadcrumb t('ui.transparency.revenues.add')
  end

  def edit
    breadcrumb
    add_breadcrumb t('edit')
  end

  def create
    @revenue.transparency_year_id = params[:year_id]
    if @revenue.save
      redirect_to admin_transparency_year_revenue_path(year_id: @revenue.year.id, id: @revenue),
                  notice: t('admin.successfully_created_html', model: @revenue.to_s)
    else
      breadcrumb
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @revenue.update(revenue_params)
      redirect_to admin_transparency_year_revenue_path(year_id: @revenue.year.id, id: @revenue),
                  notice: t('admin.successfully_updated_html', model: @revenue.to_s)
    else
      breadcrumb
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @revenue.destroy!
    redirect_to admin_transparency_year_url(@year),
                notice: t('admin.successfully_destroyed_html', model: @revenue.to_s)
  end

  protected

  def breadcrumb
    super
    add_breadcrumb t('ui.transparency.title'), admin_transparency_years_path
    add_breadcrumb @year, admin_transparency_year_path(@year)
  end

  def revenue_params
    params.require(:transparency_revenue).permit(:title, :description, :amount)
  end
end
