module Requests
  module SpecHelpers
    def json
      JSON.parse(response.body)
    end
  end
end