class Admin::BannerController < Admin::ApplicationController
  
  before_action :load_banner, :authorize_banner

  def edit
    breadcrumb
  end

  def update
    if @banner.update(banner_params)
      redirect_to admin_banner_path, notice: t('admin.successfully_updated_html', model: Banner.model_name.human)
    else
      breadcrumb
      render :edit, status: :unprocessable_entity
    end
  end

  protected

  def load_banner
    @banner = Banner.first_or_create
  end

  def authorize_banner
    authorize! :update, @banner
  end

  def breadcrumb
    super
    add_breadcrumb Banner.model_name.human, admin_banner_path
  end

  def banner_params
    params.require(:banner)
          .permit(
            :background_color, :text, :published
          )
  end
end
