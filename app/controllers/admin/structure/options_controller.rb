class Admin::Structure::OptionsController < Admin::Structure::ApplicationController
  load_and_authorize_resource class: Structure::Option

  include Admin::Reorderable

end
