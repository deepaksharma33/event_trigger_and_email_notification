require 'webmock'

if Rails.env.development? || Rails.env.staging?
  WebMock.enable!
  WebMock.disable_net_connect!(allow_localhost: true)

  WebMock.stub_request(:any, "http://api.iterable.com:443/api/users/update").to_return(status: 200, body: "", headers: {})

  WebMock.stub_request(:any, "http://api.iterable.com:443/events/track").to_return(status: 200, body: "", headers: {})

  WebMock.stub_request(:any, "http://api.iterable.com:443/api/email/target").to_return(status: 200, body: "", headers: {})
end
