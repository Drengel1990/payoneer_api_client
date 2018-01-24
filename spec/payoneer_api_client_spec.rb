RSpec.describe PayoneerApiClient do

  let(:configuration) { PayoneerApiClient.configure do |conf|
    conf.environment = 'development'
    conf.partner_id = 'XXXXXXXX'
    conf.partner_username = 'XXXXXXXX'
    conf.partner_api_password = 'XXXXXXXX'
  end }

  it 'has a version number' do
    expect(PayoneerApiClient::VERSION).not_to be nil
  end
end
