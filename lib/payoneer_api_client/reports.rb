module PayoneerApiClient

  class Reports
    class << self
      def single_payee(payee_id)
        PayoneerApiClient.make_api_request("#{METHOD_NAME[:report_single]}?payee_id=#{payee_id}", :get)
      end

      def payee_status(start_date, end_date)
        @start_date = start_date
        @end_date = end_date
        PayoneerApiClient.make_api_request(build_url, :get)
      end

      def validate_date?(date)
        formats = [FORMAT_DATE]
        formats.each do |format|
          begin
            return true if Date.strptime(date, format)
          rescue StandardError
            error_message('Date you have entered is invalid, please enter a valid date')
          end
        end
      end

      private

      def build_url
        return unless validate_date?(@start_date) && validate_date?(@end_date)
        "#{METHOD_NAME[:report_to_date]}?start_date=#{@start_date}&end_date=#{@end_date}"
      end

      def error_message(msg)
        raise Errors::GlobalError, msg
      end
    end
  end

end
