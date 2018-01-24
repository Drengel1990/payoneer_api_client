module PayoneerApiClient

  class Response
    attr_reader :code, :description, :other

    def initialize(res)
      @code = res[RESP_FIELD[:code]]
      @description = res[RESP_FIELD[:desc]]
      @other = res.delete_if { |v| RESP_FIELD.values.include?(v) }
      errors unless @code.zero?
    end

    def ok?
      code.zero?
    end

    def ==(other)
      code == other.code && description == other.description
    end

    private

    def errors
      raise Errors::GlobalError, "#{ @description }: #{ @other['hint'] }"
    end
  end

end
