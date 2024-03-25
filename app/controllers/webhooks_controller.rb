class WebhooksController < ApplicationController
  skip_before_action  :verify_authenticity_token,
                      :http_basic_authentication

  def helloasso
    payload = request.body.read
    data = nil
    begin
      data = JSON.parse(payload, symbolize_names: true)
    rescue JSON::ParserError => e
      # Invalid payload
      head :bad_request and return
    end

    # Verify the authenticity of the request
    unless request_from_helloasso?(data)
      head :forbidden
      return
    end

    # Skip if the event is not an Order from subscriptions
    HelloassoEvent.create(data: data) if is_subscription_order?(data)
    head :ok
  end

  protected

  def is_subscription_order?(data)
    event_type = data[:eventType]
    source = data.dig(:metadata, :source)
    event_type == "Order" && source == "abonnement-ecotheque"
  end

  def request_from_helloasso?(data)
    secret = data.dig(:metadata, :secret)
    secret.present? && secret == ENV["HELLOASSO_WEBHOOK_SECRET"]
  end
end