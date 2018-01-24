module PayoneerApiClient

  class PayeeStatus
    class << self
      def status(payee_id)
        PayoneerApiClient.make_api_request("payees/#{payee_id}/status", :get)
      end
    end
  end

end
