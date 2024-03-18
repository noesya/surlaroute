class SearchController < ApplicationController
  def show
    @term = params[:term].to_s.strip
    @actors = Actor.search(@term, page: params[:actors_page], per_page: 8)
    @materials = Material.search(@term, page: params[:materials_page], per_page: 8)
    @projects = Project.search(@term, page: params[:projects_page], per_page: 8)
    @technics = Technic.search(@term, page: params[:technics_page], per_page: 8)
    @lab_pages = Page.search(@term, where: { in_lab_tree: true }, page: params[:lab_pages_page], per_page: 8)
    @toolbox_pages = Page.search(@term, where: { in_toolbox_tree: true }, page: params[:toolbox_pages_page], per_page: 8)

    @no_result = [@actors, @materials, @projects, @technics, @lab_pages, @toolbox_pages].all?(&:empty?)
    breadcrumb
  end

  protected

  def breadcrumb
    super
    add_breadcrumb t('search.title')
  end
end
