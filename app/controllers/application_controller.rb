class ApplicationController < ActionController::Base
  include WithBasicAuthentication
  include WithErrors

  protected

  def breadcrumb
    add_breadcrumb t('website'), root_path
  end
end
