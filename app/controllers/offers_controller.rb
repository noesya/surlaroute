class OffersController < ApplicationController

  include ApplicationHelper

  def index
    breadcrumb
  end

  protected

  def breadcrumb
    super
    page_lab = Page.find_by(internal_identifier: 'le-lab')
    add_breadcrumb page_lab, page_path(page_lab)
    add_breadcrumb t('ui.offers.title')
  end

end