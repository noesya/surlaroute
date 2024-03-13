class HomeController < ApplicationController
  def index
    breadcrumb
    @toolbox_page = Page.find_by(internal_identifier: 'boite-a-outils')
  end
end
