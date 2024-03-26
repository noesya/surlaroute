class SubscriptionsController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!, except: :new
  before_action :ensure_user_is_not_subscribed, only: [:new, :summary, :payment]
  before_action :redirect_to_confirmation_if_active_subscription, only: [:helloasso_callback, :verification]
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
    checkout_intent_data = Helloasso::Api.new.create_checkout_intent(current_user, @product)
    redirect_url = checkout_intent_data['redirectUrl']
    redirect_to redirect_url, allow_other_host: true
  end

  # Étape 3bis : Retour d'HelloAsso avec params[:type] qui vaut 'return' ou 'error'
  def helloasso_callback
    return_type = params[:type]
    code = params[:code]
    checkout_intent_identifier = params[:checkoutIntentId]
    checkout_intent_data = Helloasso::Api.new.get_checkout_intent(checkout_intent_identifier)
    product_id = checkout_intent_data.dig('metadata', 'product_id')
    product = Product.find_by(id: product_id)
    if return_type == 'return' && code == 'succeeded'
      redirect_to verification_subscription_path(checkout_intent_id: checkout_intent_identifier)
    else
      redirect_to summary_subscription_path(product_id: product&.id),
                  alert: get_payment_error(return_type, code)
    end
  end

  # Étape 4 : Vérification (On attend d'avoir le paiement traité côté application)
  def verification
    raise_404_unless params[:checkout_intent_id].present?
  end

  # Appelé par l'étape en AJAX
  def async_verification
    subscription = current_user.subscriptions.find_by(helloasso_checkout_intent_identifier: params[:checkout_intent_id])
    location = subscription.nil? ? nil : confirmation_subscription_path
    render json: { location: location }
  end

  # Étape 4 : Confirmation
  def confirmation
    @subscription = current_user.active_subscription
    redirect_to root_path if @subscription.nil?
  end

  protected

  def ensure_user_is_not_subscribed
    redirect_to root_path, notice: t('ui.subscriptions.notices.already_subscribed') if user_signed_in? && !current_user.visitor?
  end

  def redirect_to_confirmation_if_active_subscription
    redirect_to confirmation_subscription_path if current_user.active_subscription.present?
  end

  def load_product
    @product = Product.find_by(id: params[:product_id])
    redirect_to new_subscription_path, alert: t('ui.subscriptions.errors.please_select_a_product') if @product.nil?
  end

  def get_payment_error(return_type, code)
    if return_type == 'return' && code == 'refused'
      t('ui.subscriptions.errors.refused_payment_error')
    elsif return_type == 'error'
      t('ui.subscriptions.errors.helloasso_payment_error', error: params[:error])
    else
      t('ui.subscriptions.errors.generic_payment_error')
    end
  end

  def breadcrumb
    super
    add_breadcrumb Page.lab, page_path(Page.lab)
    add_breadcrumb t('ui.offers.title'), offers_path
    add_breadcrumb t('ui.subscriptions.new.title')
  end

end