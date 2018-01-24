module PayoneerApiClient

  class Configuration

    DEVELOPMENT_ENVIRONMENT = 'development'
    PRODUCTION_ENVIRONMENT = 'production'
    DEVELOPMENT_API_URL = 'https://api.sandbox.payoneer.com/v2/programs'
    PRODUCTION_API_URL = 'https://api.payoneer.com/v2/programs'

    attr_accessor :environment, :partner_id, :partner_username, :partner_api_password

    def initialize
      @environment = DEVELOPMENT_ENVIRONMENT
    end

    def production?
      environment == PRODUCTION_ENVIRONMENT
    end

    def api_url
      create_url(production? ? PRODUCTION_API_URL : DEVELOPMENT_API_URL)
    end

    def create_url(url)
      "#{url}/#{partner_id}"
    end

    def validate!
      raise Errors::ConfigurationError unless partner_id && partner_username && partner_api_password
    end
  end

end
