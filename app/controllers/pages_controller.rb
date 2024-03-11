class PagesController < ApplicationController

  def show
    @page = Page.find_by!(path: params[:path])
    breadcrumb
  end

  protected

  def breadcrumb
    super
    @page.ancestors_and_self.each do |page|
      add_breadcrumb page, page
    end
  end

end
