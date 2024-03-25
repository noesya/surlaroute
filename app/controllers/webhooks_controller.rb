class WebhooksController < ApplicationController
  skip_before_action  :verify_authenticity_token,
                      :http_basic_authentication

  def helloasso
    payload = request.body.read
    data = nil
    begin
      data = JSON.parse(payload, symbolize_names: true) || {}
    rescue JSON::ParserError => e
      # Invalid payload
      head :bad_request and return
    end

    # Skip if the event is not an Order from subscriptions
    head :ok and return unless is_subscription_order?(data)
    # Verify the authenticity of the request
    head :forbidden and return unless request_from_helloasso?(data)

    HelloassoEvent.create(data: data)
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
    secret == ENV["HELLOASSO_WEBHOOK_SECRET"]
  end
end