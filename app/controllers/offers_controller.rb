class OffersController < ApplicationController

  def index
    breadcrumb
  end

  protected

  def breadcrumb
    super
    lab_page = Page.find_by(internal_identifier: 'le-lab')
    add_breadcrumb lab_page&.to_s, lab_page&.slug
    add_breadcrumb t('ui.offers.title')
  end

end