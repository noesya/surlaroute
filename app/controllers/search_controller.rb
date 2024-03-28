class SearchController < ApplicationController
  def show
    @term = params[:term].to_s.strip
    @actors = Actor.search(@term, where: { published: true }, page: params[:actors_page], per_page: 8)
    @materials = Material.search(@term, where: { published: true }, page: params[:materials_page], per_page: 8)
    @projects = Project.search(@term, where: { published: true }, page: params[:projects_page], per_page: 8)
    @technics = Technic.search(@term, where: { published: true }, page: params[:technics_page], per_page: 8)
    @lab_pages = Page.search(@term, where: { ancestor_kind: 'lab' }, page: params[:lab_pages_page], per_page: 8)
    @toolbox_pages = Page.search(@term, where: { ancestor_kind: 'toolbox' }, page: params[:toolbox_pages_page], per_page: 8)

    @no_result = [@actors, @materials, @projects, @technics, @lab_pages, @toolbox_pages].all?(&:empty?)
    breadcrumb
  end

  protected

  def breadcrumb
    super
    add_breadcrumb t('search.title')
  end
end
