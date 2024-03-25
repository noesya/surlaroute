module Helloasso::Api::WithAuthentication
  extend ActiveSupport::Concern

  private

  def authenticate
    @token = HelloassoToken.first_or_initialize
    unless access_token_valid?
      auth_response = authenticate_with_refresh_token(@token.refresh_token) || authenticate_with_client_credentials
      @token.update(
        access_token: auth_response.body['access_token'],
        refresh_token: auth_response.body['refresh_token']
      )
    end
  end

  def access_token_valid?
    return false if @token.access_token.blank?
    response = connection.get('/v5/users/me/organizations', {}, authorization_header)
    response.status == 200
  rescue Faraday::ClientError
    false
  end

  def authenticate_with_refresh_token(refresh_token)
    return false if refresh_token.blank?
    connection.post('/oauth2/token', {
      client_id: ENV["HELLOASSO_CLIENT_ID"],
      refresh_token: refresh_token,
      grant_type: "refresh_token"
    })
  rescue Faraday::ClientError
    false
  end

  def authenticate_with_client_credentials
    connection.post('/oauth2/token', {
      client_id: "#{ENV["HELLOASSO_CLIENT_ID"]}",
      client_secret: ENV["HELLOASSO_CLIENT_SECRET"],
      grant_type: "client_credentials"
    })
  end
end