# PayoneerApiClient

[![Build Status](https://travis-ci.org/Drengel1990/payoneer_api_client.svg)](https://travis-ci.org/Drengel1990/payoneer_api_client)

 **_PayoneerApiClient_** - uses REST API  payout services Payoneer.
 
 Payoneer provides a complete and easy-to-implement solution for disbursing funds to
 payees globally. Integrating the solution involves two steps: <br>
 1. Payee registration–Clients call `payees/login-link` or `payees/registration-link` to retrieve a unique URL for a payee to on-board Payoneer. On-boarding is implemented with client branded web pages that are hosted by Payoneer. <br>
 2. Submitting payment instructions to Payoneer,via one of two supported interfaces: <br><br>
 2.1 Automated interface: Clients can implement the REST HTTPS Request/Response interface for automating data submission including payment instructions and retrieving information. The REST APIs are described in section 4 of this document. Credentials for submitting API calls to sandbox and production environments will be provided during account setup. <br><br>
 2.2 Manual interface: Clients can use the Payoneer Administration Console to manually submit payment instructions and other data to Payoneer’s system and to access reports. The Payments tab in the console supports initiating single payments and uploading payment batch files to Payoneer. <br>

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'payoneer_api_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install payoneer_api_client

## Usage

```ruby

    require 'payoneer_api_client'
    
    PayoneerApiClient.configure do |conf|
      conf.environment = 'development'
      conf.partner_id = 'XXXXXXXX'
      conf.partner_username = 'XXXXXXXX'
      conf.partner_api_password = 'XXXXXXXX'
    end
    
    # Echo
    PayoneerApiClient::System.status.ok?
    => true
    
    # Query Account Balance
    PayoneerApiClient::Balance.status.other
    => {"balance"=>212.68, "currency"=>"USD", "fees_due"=>0.0}
    
    # Get Version
    PayoneerApiClient::ApiVersion.status.other
    => {"version"=>"4.18"}
    
    # Create Login Link
    PayoneerApiClient::Login.create_url('ID123', 'ABC123', 'https://www.yoursite.com').other
    => {"login_link"=>"https://payouts.sandbox.payoneer.com/partners/lp.aspx?token=0a7ece12cfa64ea1baa66c0c778XXXXXXXXXXXX"}
    
    # Create Registration Link
    PayoneerApiClient::Registration.create_url('ID124', 'ABC124', 'https://www.yoursite.com').other
    => {"registration_link"=>"https://payouts.sandbox.payoneer.com/partners/lp.aspx?token=eaad141d0123448a820b6dc926XXXXXXXXXXXXX"}
    
    # Get Payee Status
    PayoneerApiClient::PayeeStatus.status('ID123').other
    => {"status"=>"ACTIVE"}
    
    # Get Payee Details
    PayoneerApiClient::PayeeDetails.status('ID123').other
    => {"type"=>"INDIVIDUAL", "status"=>"ACTIVE", "registration_date"=>"2016-01-22", "contact"=>{"first_name"=>"Test", "last_name"=>"Test", "email"=>"test@gmail.com", "mobile"=>"XXXXXXXXXXX", "phone"=>""}, "address"=>{"country"=>"XX", "state"=>"", "zip_code"=>"XXXXX", "address_line_1"=>"Test", "address_line_2"=>"Test", "city"=>"Test"}, "payout_method"=>{"type"=>"BANK", "currency"=>"USD"}}
    
    # Submit Payout
    pay = PayoneerApiClient::Payout.new({
                                        payee_id: 'ID123',
                                        amount: 25.22,
                                        client_reference_id: 'test123456',
                                        description: 'TEST',
                                        currency: 'USD'
                                    })
    puts pay.send_payouts.other
    => {"payout_id"=>"9023269", "amount"=>25.22, "currency"=>"USD"}
    
    # Cancel Payout
    PayoneerApiClient::Payout.cancel('test123456').other
    => {"payout_id"=>"9023269"}
    
    # Get Payout Details
    PayoneerApiClient::Payout.details('test123456').other
    => {"payout_id"=>"9023269", "status"=>"Cancelled", "payee_id"=>"ID123", "payout_date"=>"2018-01-24T08:40:06.053", "amount"=>25.22, "currency"=>"USD"}
    
    # Get Single Reports
    PayoneerApiClient::Reports.single_payee('ID123').other
    => {"payee_id"=>"ID123", "status"=>"Active", "registration_date"=>"2018-01-19", "payout_method"=>"iACH", "company"=>{}, "total_amount"=>282.08, "payouts"=>[{"client_reference_id"=>"ABC123", "date"=>"2018-01-23T09:21:28", "amount"=>55.1, "currency"=>"USD", "description"=>"TEST", "status"=>"Funded"}, {"client_reference_id"=>"test1234", "date"=>"2018-01-24T08:12:30", "amount"=>25.22, "currency"=>"USD", "description"=>"TEST", "status"=>"Funded"}, {"client_reference_id"=>"1234tttt", "date"=>"2018-01-23T02:10:01", "amount"=>25.22, "currency"=>"USD", "description"=>"TEST", "status"=>"Cancelled"}, {"client_reference_id"=>"test1234567890", "date"=>"2018-01-24T07:54:32", "amount"=>25.22, "currency"=>"USD", "description"=>"TEST", "status"=>"Cancelled"}, {"client_reference_id"=>"test12", "date"=>"2018-01-24T08:09:20", "amount"=>25.22, "currency"=>"USD", "description"=>"TEST", "status"=>"Cancelled"}, {"client_reference_id"=>"test123456", "date"=>"2018-01-24T08:40:06", "amount"=>25.22, "currency"=>"USD", "description"=>"TEST", "status"=>"Cancelled"}, {"client_reference_id"=>"1234tttt", "date"=>"2018-01-23T02:17:31", "amount"=>25.22, "currency"=>"USD", "description"=>"Payment 1234tttt refunded", "status"=>"Refund"}, {"client_reference_id"=>"test1234567890", "date"=>"2018-01-24T07:54:33", "amount"=>25.22, "currency"=>"USD", "description"=>"Payment test1234567890 refunded", "status"=>"Refund"}, {"client_reference_id"=>"test12", "date"=>"2018-01-24T08:09:21", "amount"=>25.22, "currency"=>"USD", "description"=>"Payment test12 refunded", "status"=>"Refund"}, {"client_reference_id"=>"test123456", "date"=>"2018-01-24T08:41:03", "amount"=>25.22, "currency"=>"USD", "description"=>"Payment test123456 refunded", "status"=>"Refund"}]}
    

    # Get Reports
    start_date = Date.today.prev_month.strftime('%Y-%m-%d')
    end_date = Date.today.strftime('%Y-%m-%d')
    
    PayoneerApiClient::Reports.payee_status(start_date, end_date).other
    => {"payees"=>[{"payee_id"=>"ID123", "status"=>"Active", "registration_date"=>"2018-01-19", "payout_method"=>"BANK", "total_amount"=>282.08, "payouts"=>[{"client_reference_id"=>"ABC123", "date"=>"2018-01-23T09:21:28", "amount"=>55.1, "currency"=>"USD", "description"=>"TEST", "status"=>"Funded"}, {"client_reference_id"=>"test1234", "date"=>"2018-01-24T08:12:30", "amount"=>25.22, "currency"=>"USD", "description"=>"TEST", "status"=>"Funded"}, {"client_reference_id"=>"1234tttt", "date"=>"2018-01-23T02:10:01", "amount"=>25.22, "currency"=>"USD", "description"=>"TEST", "status"=>"Cancelled"}, {"client_reference_id"=>"test1234567890", "date"=>"2018-01-24T07:54:32", "amount"=>25.22, "currency"=>"USD", "description"=>"TEST", "status"=>"Cancelled"}, {"client_reference_id"=>"test12", "date"=>"2018-01-24T08:09:20", "amount"=>25.22, "currency"=>"USD", "description"=>"TEST", "status"=>"Cancelled"}, {"client_reference_id"=>"test123456", "date"=>"2018-01-24T08:40:06", "amount"=>25.22, "currency"=>"USD", "description"=>"TEST", "status"=>"Cancelled"}, {"client_reference_id"=>"1234tttt", "date"=>"2018-01-23T02:17:31", "amount"=>25.22, "currency"=>"USD", "description"=>"Payment 1234tttt refunded", "status"=>"Refund"}, {"client_reference_id"=>"test1234567890", "date"=>"2018-01-24T07:54:33", "amount"=>25.22, "currency"=>"USD", "description"=>"Payment test1234567890 refunded", "status"=>"Refund"}, {"client_reference_id"=>"test12", "date"=>"2018-01-24T08:09:21", "amount"=>25.22, "currency"=>"USD", "description"=>"Payment test12 refunded", "status"=>"Refund"}, {"client_reference_id"=>"test123456", "date"=>"2018-01-24T08:41:03", "amount"=>25.22, "currency"=>"USD", "description"=>"Payment test123456 refunded", "status"=>"Refund"}]}]}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Drengel1990/payoneer_api_client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).