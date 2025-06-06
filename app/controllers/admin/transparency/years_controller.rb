class Admin::Transparency::YearsController < Admin::ApplicationController
  load_and_authorize_resource class: 'Transparency::Year'

  def index
    @years = @years.page(params[:page])
    breadcrumb
  end

  def show
    breadcrumb
  end

  def new
  end

  def edit
  end

  def create
    if @year.save
      redirect_to [:admin, @year], notice: t('admin.successfully_created_html', model: @year.to_s)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @year.update(year_params)
      redirect_to [:admin, @year], notice: t('admin.successfully_updated_html', model: @year.to_s)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @year.destroy!
    redirect_to admin_transparency_years_url, notice: t('admin.successfully_destroyed_html', model: @year.to_s)
  end

  protected

  def breadcrumb
    super
    add_breadcrumb t('ui.transparency.title'), admin_transparency_years_path
    breadcrumb_for @year
  end

  def year_params
    params.require(:transparency_year).permit(:value)
  end
end
