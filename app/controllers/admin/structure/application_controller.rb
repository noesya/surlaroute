class Admin::Structure::ApplicationController < Admin::ApplicationController

  protected

  def default_url_options
    {
      path_params: {
        about_class: about_class
      }
    }
  end

  def about_class
    params[:about_class]
  end
end
