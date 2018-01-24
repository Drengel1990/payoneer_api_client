require 'rest-client'
require 'json/ext'


# Version
require 'payoneer_api_client/version'

# Configuration
require 'payoneer_api_client/configuration'

# Resources
require 'payoneer_api_client/balance'
require 'payoneer_api_client/api_version'
require 'payoneer_api_client/system'
require 'payoneer_api_client/response'
require 'payoneer_api_client/reports'
require 'payoneer_api_client/registration'
require 'payoneer_api_client/payout'
require 'payoneer_api_client/payee_status'
require 'payoneer_api_client/payee_details'
require 'payoneer_api_client/login'

# Errors
require 'payoneer_api_client/errors/global_error'
require 'payoneer_api_client/errors/configuration_error'


module PayoneerApiClient

  METHOD_NAME = {  balance: 'balance',
                   system: 'echo',
                   version: 'api-version',
                   login: 'payees/login-link',
                   registration: 'payees/registration-link',
                   payouts: 'payouts',
                   report_single: 'reports/payee_details',
                   report_to_date: 'reports/payees_status' }.freeze

  PAYOUT_METHODS = { prepaid_card: 'PREPAID_CARD', bank: 'BANK', paypal: 'PAYPAL' }.freeze

  RESP_FIELD = { code: 'code', desc: 'description', audit: 'audit_id' }.freeze

  FORMAT_DATE = '%Y-%m-%d'

  class << self

    def configure
      yield(configuration)
    end

    def make_api_request(method_name, method = :post, params = {})
      configuration.validate!
      begin
        response = RestClient::Request.execute(method: method,
                                               url: build_url(method_name),
                                               user: configuration.partner_username,
                                               password: configuration.partner_api_password,
                                               headers: { accept: :json, content_type: :json },
                                               payload: params.to_json)
      rescue RestClient::Exception => e
        response = e.response
      end
      Response.new(JSON.parse(response))
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def build_url(method_name)
      "#{configuration.api_url}/#{method_name}"
    end
  end
end
