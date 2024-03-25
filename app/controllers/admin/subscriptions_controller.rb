class Admin::SubscriptionsController < Admin::ApplicationController
  load_and_authorize_resource

  def index
    @subscriptions = @subscriptions.ordered.page(params[:page])
    breadcrumb
  end

  def show
    breadcrumb
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Subscription.model_name.human(count: 2), admin_subscriptions_path
    breadcrumb_for @subscription
  end
end
