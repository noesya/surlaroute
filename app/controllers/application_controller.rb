class ApplicationController < ActionController::Base
  include WithBasicAuthentication
  include WithErrors

  before_action :load_region, :load_banner

  protected

  def breadcrumb
    add_breadcrumb t('home'), root_path(region_slug: nil)
    if @region.present?
      add_breadcrumb Region.model_name.human(count: 2), regions_path(region_slug: nil)
      add_breadcrumb @region, region_path(@region, region_slug: nil)
    end
  end

  def load_region
    return unless params.has_key?(:region_slug)
    @region = Region.find_by!(slug: params[:region_slug])
  end

  def load_banner
    @banner = Banner.first
  end

  def default_url_options
    {
      path_params: {
        region_slug: @region&.slug
      }
    }
  end
end
