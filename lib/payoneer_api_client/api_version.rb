module PayoneerApiClient

  class ApiVersion
    class << self
      def status
        PayoneerApiClient.make_api_request(METHOD_NAME[:version], :get)
      end
    end
  end

end
