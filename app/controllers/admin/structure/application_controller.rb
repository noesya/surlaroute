class Admin::Structure::ApplicationController < Admin::ApplicationController

  protected

  def default_url_options
    options = {}    
    options[:about_class] = about_class
    options
  end

  def about_class
    params[:about_class]
  end
end
