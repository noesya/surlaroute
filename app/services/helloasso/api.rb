class Helloasso::Api
  include WithAuthentication
  include WithRouting

  def initialize
    authenticate
  end

  def get_checkout_intent(identifier)
    response = connection.get(
      "/v5/organizations/#{ENV["HELLOASSO_ORGANIZATION_SLUG"]}/checkout-intents/#{identifier}",
      {},
      authorization_header
    )
    response.body
  end

  def create_checkout_intent(user, product)
    checkout_params = {
      totalAmount: product.helloasso_price,
      initialAmount: product.helloasso_price,
      itemName: "#{ENV["HELLOASSO_SUBSCRIPTION_NAME"]} - #{product.name}",
      backUrl: summary_subscription_url(product_id: product.id),
      errorUrl: helloasso_callback_subscription_url(type: 'error'),
      returnUrl: helloasso_callback_subscription_url(type: 'return'),
      containsDonation: false,
      payer: {
        firstName: user.first_name,
        lastName: user.last_name,
        email: user.email
      },
      metadata: {
        product_id: product.id,
        user_id: user.id
      }
    }

    response = connection.post(
      "/v5/organizations/#{ENV["HELLOASSO_ORGANIZATION_SLUG"]}/checkout-intents",
      checkout_params.to_json,
      { "Content-Type": "application/json" }.merge(authorization_header)
    )
    response.body
  end

  private

  def authorization_header
    { "Authorization" => "Bearer #{@token.access_token}" }
  end

  def connection
    @connection ||= Faraday.new(url: ENV["HELLOASSO_API_URL"]) do |f|
      # Automatically encodes form data in application/x-www-form-urlencoded
      f.request :url_encoded
      # Automatically decodes JSON
      f.response :json
      # Automatically raises errors when response status is 4xx or 5xx
      f.response :raise_error
      # Automatically log requests and responses in development environment
      f.response :logger, nil, { headers: true, bodies: true, errors: true, log_level: :debug } if Rails.env.development?
    end
  end
end