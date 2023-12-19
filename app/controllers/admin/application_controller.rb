class Admin::ApplicationController < ApplicationController

  before_action :authenticate_user!, :ensure_role!

  layout 'admin/layouts/application'

  protected

  def breadcrumb
    add_breadcrumb t('admin.dashboard'), admin_root_path
  end

  def breadcrumb_for(object)
    return if object.nil?
    object.persisted? ? add_breadcrumb(object.to_s, [:admin, object])
                      : add_breadcrumb(t('create'))
  end

  private

  def ensure_role!
    redirect_to root_path if current_user.visitor?
  end

  def default_url_options
    {}
  end

end
