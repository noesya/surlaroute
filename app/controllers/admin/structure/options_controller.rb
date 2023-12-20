class Admin::Structure::OptionsController < Admin::Structure::ApplicationController
  load_and_authorize_resource class: Structure::Option, find_by: :slug

  include Admin::Reorderable

end
