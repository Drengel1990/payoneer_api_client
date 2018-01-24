module PayoneerApiClient

  class Login
    class << self
      def create_url(payee_id, client_session = nil, url = nil, time = 10)
        params = {
            payee_id: payee_id,
            client_session_id: client_session,
            redirect_url: url,
            redirect_time: time
        }
        PayoneerApiClient.make_api_request(METHOD_NAME[:login], :post, params)
      end
    end
  end

end
