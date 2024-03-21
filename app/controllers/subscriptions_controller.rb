class SubscriptionsController < ApplicationController
  include ApplicationHelper

  def new
    breadcrumb
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Page.lab, page_path(Page.lab)
    add_breadcrumb t('ui.offers.title'), offers_path
    add_breadcrumb t('ui.subscriptions.new.title')
  end

end