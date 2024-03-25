class OffersController < ApplicationController
  include ApplicationHelper

  def index
    breadcrumb
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Page.lab, page_path(Page.lab)
    add_breadcrumb t('ui.offers.title')
  end

end