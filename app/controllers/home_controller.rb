class HomeController < ApplicationController
  def index
    @home_page = Page.find_by(internal_identifier: 'home')
    @toolbox_page = Page.find_by(internal_identifier: 'boite-a-outils')
    @actors_count = Actor.published.count
    @materials_count = Material.published.count
    @projects_count = Project.published.count
    @technics_count = Technic.published.count
    @regions_count = Region.count
    breadcrumb
  end
end
