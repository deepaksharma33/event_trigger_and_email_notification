require 'rails_helper'

RSpec.describe IterableService do
  let(:user) { create(:user) }
  let(:event) { 'test_event' }

  subject { described_class.new(user, event) }

  describe '#create_user' do
    it 'sends a POST request to create a user' do
      stub_request(:post, "http://api.iterable.com:443/api/users/update").
        with(
          body: "{\"email\":\"#{user.email}\"}",
          headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'Api-Key'=>'test123',
       	  'Content-Type'=>'application/json',
       	  'Host'=>'api.iterable.com',
       	  'User-Agent'=>'Ruby'
        }).
        to_return(status: 200, body: '{"message": "User created successfully"}', headers: {})

      response = subject.create_user

      expect(response.code).to eq("200")
      expect(response.body).to eq("{\"message\": \"User created successfully\"}")
    end
  end

  describe '#create_event' do
    it 'sends a POST request to create an event' do
      stub_request(:post, "http://api.iterable.comevents:443/track").
        with(
          body: "{\"email\":\"#{user.email}\",\"eventName\":\"test_event\"}",
          headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'Api-Key'=>'test123',
       	  'Content-Type'=>'application/json',
       	  'Host'=>'api.iterable.comevents',
       	  'User-Agent'=>'Ruby'
        }).
        to_return(status: 200, body: '{"message": "Event created successfully"}', headers: {})

      response = subject.create_event

      expect(response.code).to eq("200")
      expect(response.body).to eq("{\"message\": \"Event created successfully\"}")
    end
  end

  describe '#send_email' do
    it 'sends a POST request to send an email' do
      stub_request(:post, "http://api.iterable.com:443/api/email/target").
      with(
        body: "{\"email\":\"#{user.email}\",\"eventName\":\"test_event\"}",
        headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Api-Key'=>'test123',
        'Content-Type'=>'application/json',
        'Host'=>'api.iterable.com',
        'User-Agent'=>'Ruby'
        }).
      to_return(status: 200, body: '{"message": "Email sent successfully"}', headers: {})

      response = subject.send_email

      expect(response.code).to eq("200")
      expect(response.body).to eq('{"message": "Email sent successfully"}')
    end
  end
end
