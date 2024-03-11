class PagesController < ApplicationController

  def show
    @page = Page.find_by!(path: params[:page_path])
    @parent = Page.find_by!(path: params[:parent_page_path]) if params.has_key?(:parent_page_path)
    breadcrumb
    add_breadcrumb @parent, page_path(@parent) if @parent
    add_breadcrumb @page
  end

  protected

  def breadcrumb
    super
  end

end
