class SearchController < ApplicationController
  def show
    @term = params[:term].to_s.strip
    breadcrumb
  end

  protected

  def breadcrumb
    super
    add_breadcrumb "Recherche"
  end
end
