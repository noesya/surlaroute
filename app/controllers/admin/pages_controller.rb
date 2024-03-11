class Admin::PagesController < Admin::ApplicationController
  load_and_authorize_resource find_by: :path

  def index
    @pages = @pages.autofilter(params[:filters]).ordered.page(params[:page])
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
    if @page.save
      redirect_to [:admin, @page], notice: t('admin.successfully_created_html', model: @page.to_s)
    else
      breadcrumb
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @page.update(page_params)
      redirect_to [:admin, @page], notice: t('admin.successfully_updated_html', model: @page.to_s)
    else
      breadcrumb
      add_breadcrumb t('edit')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    unless @page.internal_identifier.present?
      @page.destroy
      redirect_to admin_pages_url, notice: t('admin.successfully_destroyed_html', model: @page.to_s)
    else
      redirect_to admin_pages_url, alert: t('admin.cant_destroy', name: @page.to_s)
    end
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Page.model_name.human(count: 2), admin_pages_path
    if @page
      breadcrumb_for @page.parent if @page.parent
      breadcrumb_for @page
    end
  end

  def page_params
    params.require(:page)
          .permit(
            :name, :slug, :description, :parent_id, :position
          )
  end
end
