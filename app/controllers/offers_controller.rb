class OffersController < ApplicationController

  def index
    breadcrumb
  end

  protected

  def breadcrumb
    super
    add_breadcrumb 'Le Lab'
    add_breadcrumb 'Comment nous rejoindre ?'
  end

end