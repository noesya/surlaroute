class HomeController < ApplicationController
  def index
    breadcrumb
    @toolbox_page = Page.find_by(path: "boite-a-outils")
  end
end
