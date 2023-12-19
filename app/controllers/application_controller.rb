class ApplicationController < ActionController::Base
  include WithBasicAuthentication
  include WithErrors

  before_action :load_region

  protected

  def breadcrumb
    add_breadcrumb t('website'), root_path(region_slug: nil)
    add_breadcrumb @region, region_path(@region, region_slug: nil) if @region.present?
  end

  def load_region
    return unless params.has_key?(:region_slug)
    @region = Region.find_by!(slug: params[:region_slug])
  end

  def default_url_options
    options = {}
    options[:region_slug] = @region.slug if @region.present?
    options
  end
end
