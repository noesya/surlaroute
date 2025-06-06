class TransparencyController < ApplicationController

  def index
    @years = Transparency::Year.ordered
    breadcrumb
  end

  def show
    @year = Transparency::Year.find_by(value: params[:year])
    breadcrumb
    add_breadcrumb @year
  end

  protected

  def breadcrumb
    super
    add_breadcrumb t('ui.transparency.title'), transparency_path
  end

end