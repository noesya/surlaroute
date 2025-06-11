class HomeController < ApplicationController
  def index
    @home_page = Page.find_by(internal_identifier: 'home')
    @actors_count = Actor.published.count
    @materials_count = Material.published.count
    @projects_count = Project.published.count
    @technics_count = Technic.published.count
    @tours_count = Tour.published.count
    @regions_count = Region.count
    breadcrumb
  end
end
