class SearchController < ApplicationController
  def show
    @term = params[:term].to_s.strip
    @actors = Actor.search(@term, fields: [:name], match: :word_start, page: params[:actors_page], per_page: 8)
    @materials = Material.search(@term, fields: [:name], match: :word_start, page: params[:materials_page], per_page: 8)
    @projects = Project.search(@term, fields: [:name], match: :word_start, page: params[:projects_page], per_page: 8)
    @technics = Technic.search(@term, fields: [:name], match: :word_start, page: params[:technics_page], per_page: 8)
    @lab_pages = Page.search(@term, fields: [:name], where: { in_lab_tree: true }, match: :word_start, page: params[:lab_pages_page], per_page: 8)
    @toolbox_pages = Page.search(@term, fields: [:name], where: { in_toolbox_tree: true }, match: :word_start, page: params[:toolbox_pages_page], per_page: 8)

    @no_result = [@actors, @materials, @projects, @technics, @lab_pages, @toolbox_pages].all?(&:empty?)
    breadcrumb
  end

  protected

  def breadcrumb
    super
    add_breadcrumb t('search.title')
  end
end
