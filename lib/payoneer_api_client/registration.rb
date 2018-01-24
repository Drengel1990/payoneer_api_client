module PayoneerApiClient

  class Registration
    class << self
      def create_url(payee_id, client_session = nil, url = nil, time = 10, payout_methods = PAYOUT_METHODS.values)
        params = {
            payee_id: payee_id,
            client_session_id: client_session,
            redirect_url: url,
            redirect_time: time,
            payout_methods_list: payout_methods
        }
        PayoneerApiClient.make_api_request(METHOD_NAME[:registration], :post, params)
      end
    end
  end

end
