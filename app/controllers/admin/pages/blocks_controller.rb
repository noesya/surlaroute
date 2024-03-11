class Admin::Pages::BlocksController < Admin::ApplicationController
  load_and_authorize_resource :page, 
                              class: Page,
                              find_by: :slug,
                              id_param: :page_id

  load_and_authorize_resource class: Page::Block,
                              through: :page

  def new
    @block = @page.blocks.new
    breadcrumb
  end

  def edit
    breadcrumb
    add_breadcrumb t('edit')
  end

  def create
    if @block.save
      redirect_to [:admin, @page], notice: t('admin.successfully_created_html', model: @block.to_s)
    else
      breadcrumb
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @block.update(block_params)
      redirect_to [:admin, @page], notice: t('admin.successfully_updated_html', model: @block.to_s)
    else
      breadcrumb
      add_breadcrumb t('edit')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @block.destroy
    redirect_to admin_page_path(@page), notice: t('admin.successfully_destroyed_html', model: @block.to_s)
  end

  protected

  def breadcrumb
    super
    breadcrumb_for @block
  end

  def block_params
    params.require(:page_block)
          .permit(
            :name, :path, :description, :position
          )
  end
end
