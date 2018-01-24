module PayoneerApiClient

  class PayeeDetails
    class << self
      def status(payee_id)
        PayoneerApiClient.make_api_request("payees/#{payee_id}/details", :get)
      end
    end
  end

end
