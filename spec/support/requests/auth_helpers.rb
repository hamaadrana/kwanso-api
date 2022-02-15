require 'devise/jwt/test_helpers'

module Requests
  module AuthHelpers
    def auth_headers_for(user)
      headers = {}
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
    end
  end
end