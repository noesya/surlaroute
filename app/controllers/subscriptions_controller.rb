class SubscriptionsController < ApplicationController
  include ApplicationHelper

  before_action :load_product, only: [:summary, :payment]

  # Étape 1 : Choix d'abonnement
  def new
    @products = Product.all.ordered
    breadcrumb
  end

  # Étape 2 : Récapitulatif
  def summary
  end

  # Étape 3 : Paiement (redirection vers HelloAsso Checkout)
  def payment
  end

  # Étape 4 : Confirmation
  def confirm
  end

  protected

  def load_product
    @product = Product.find_by(id: params[:product_id])
    redirect_to new_subscription_path, alert: t('ui.subscriptions.errors.please_select_a_product') if @product.nil?
  end

  def breadcrumb
    super
    add_breadcrumb Page.lab, page_path(Page.lab)
    add_breadcrumb t('ui.offers.title'), offers_path
    add_breadcrumb t('ui.subscriptions.new.title')
  end

end