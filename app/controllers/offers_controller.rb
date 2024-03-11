class OffersController < ApplicationController

  def index
    breadcrumb
  end

  protected

  def breadcrumb
    super
    add_breadcrumb 'Le Lab', Page.find_by(internal_identifier: 'le-lab')&.calculated_path
    add_breadcrumb 'Comment nous rejoindre ?'
  end

end