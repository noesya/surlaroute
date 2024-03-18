class SearchController < ApplicationController
  def show
    @term = params[:term].to_s.strip
    @actors = Actor.search(@term, fields: [:name], match: :word_start, page: params[:page], per_page: 8)
    @materials = Material.search(@term, fields: [:name], match: :word_start, page: params[:page], per_page: 8)
    @projects = Project.search(@term, fields: [:name], match: :word_start, page: params[:page], per_page: 8)
    @technics = Technic.search(@term, fields: [:name], match: :word_start, page: params[:page], per_page: 8)
    @lab_pages = Page.search(@term, fields: [:name], match: :word_start, page: params[:page], per_page: 8)
    @toolbox_pages = Page.search(@term, fields: [:name], match: :word_start, page: params[:page], per_page: 8)
    breadcrumb
  end

  protected

  def breadcrumb
    super
    add_breadcrumb "Recherche"
  end
end
