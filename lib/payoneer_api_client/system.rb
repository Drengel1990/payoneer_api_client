module PayoneerApiClient

  class System
    class << self
      def status
        PayoneerApiClient.make_api_request(METHOD_NAME[:system], :get)
      end
    end
  end

end
