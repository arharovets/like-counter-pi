# frozen_string_literal: true

class AuthorizationService
  def initialize(headers = {})
    @headers = headers
  end

  def authenticate_request!
    verify_token
  end

  private

  def http_token
    auth_header = @headers['Authorization']

    auth_header.split.last if auth_header.present?
  end

  def verify_token
    JsonWebToken.verify(http_token)
  end
end
