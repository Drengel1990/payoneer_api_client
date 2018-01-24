module PayoneerApiClient

  class Payout
    attr_reader :payee_id, :amount, :client_reference_id

    def initialize(pr = {})
      @payee_id ||= pr[:payee_id]
      @amount ||= pr[:amount]
      @client_reference_id ||= pr[:client_reference_id]
      @description ||= pr[:description]
      @payout_date ||= pr[:payout_date]
      @currency ||= pr[:currency]
      @group_id ||= pr[:group_id]
    end

    def send_payouts
      PayoneerApiClient.make_api_request(METHOD_NAME[:payouts], :post, params_payout) if payouts_valid?
    end

    def payouts_valid?
      if @payee_id.nil? && @amount.nil? && @client_reference_id.nil?
        show_error
      else
        true
      end
    end

    class << self
      def details(client_reference_id)
        PayoneerApiClient.make_api_request("payouts/#{client_reference_id}", :get)
      end

      def cancel(client_reference_id)
        PayoneerApiClient.make_api_request("payouts/#{client_reference_id}/cancel", :post)
      end
    end

    private

    def params_payout(pr = {})
      pr[:payee_id] = @payee_id unless @payee_id.nil?
      pr[:amount] = normal_amount
      pr[:client_reference_id] = @client_reference_id unless @client_reference_id.nil?
      pr[:description] = @description unless @description.nil?
      pr[:payout_date] = normal_payout_date
      pr[:currency] = @currency unless @currency.nil?
      pr[:group_id] = @group_id unless @group_id.nil?
      pr
    end

    def normal_payout_date
      @payout_date.nil? ? Time.now.strftime(FORMAT_DATE) : @payout_date
    end

    def normal_amount
      format('%.2f', @amount)
    end

    def show_error
      raise Errors::GlobalError, 'Please input field payee_id, amount and client_reference_id'
    end
  end

end
