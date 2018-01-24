module PayoneerApiClient

  class Balance
    class << self
      def status
        PayoneerApiClient.make_api_request(METHOD_NAME[:balance], :get)
      end
    end
  end

end
