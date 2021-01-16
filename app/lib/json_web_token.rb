# frozen_string_literal: true

require 'net/http'
require 'uri'

class JsonWebToken
  def self.verify(token)
    JWT.decode(token, nil,
               true, # Verify the signature of this token
               algorithm: 'RS256',
               iss: Rails.application.credentials.auth0[:domain],
               verify_iss: true,
               aud: Rails.application.credentials.auth0[:api_identifier],
               verify_aud: true) do |header|
      jwks_hash[header['kid']]
    end
  end

  def self.jwks_hash
    jwks_raw = Net::HTTP.get URI("#{Rails.application.credentials.auth0[:domain]}.well-known/jwks.json")
    jwks_keys = Array(JSON.parse(jwks_raw)['keys'])
    Hash[jwks_keys.map { |key| [key['kid'], get_public_key(key['x5c'].first)] }]
  end

  private

  def get_public_key(token)
    decoded_token = Base64.decode64(token)

    OpenSSL::X509 :Certificate.new(decoded_token).public_key
  end
end
