require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  let(:email)    { Faker::Internet.email }
  let(:password) { Faker::Internet.password }

  let(:user_params)    { { email: email, password: password, password_confirmation: password } }
  let(:invalid_params) { { email: email, password: password, password_confirmation: "#{password}mismatch" } }

  let(:user_creation_request) do
    a_request(:post, 'http://api.iterable.com:443/api/users/update')
      .with(
        body: "{\"email\":\"#{email}\"}",
        headers: {
          'Accept': '*/*',
          'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Api-Key': 'test123',
          'Content-Type': 'application/json',
          'Host': 'api.iterable.com',
          'User-Agent': 'Ruby'
        }
      )
  end

  before do
    # Set up the Devise mapping for the user model.
    @request.env["devise.mapping"] = Devise.mappings[:user]

    stub_request(:post, "http://api.iterable.com:443/api/users/update").
      with(
        body: "{\"email\":\"#{email}\"}",
        headers: {
          'Accept': '*/*',
          'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Api-Key': 'test123',
          'Content-Type': 'application/json',
          'Host': 'api.iterable.com',
          'User-Agent': 'Ruby'
        }
      ).to_return(status: 200, body: "", headers: {})
  end

  describe 'POST #create' do
    context 'when user registration is successful' do
      it 'creates a user and sends data to Iterable' do
        post :create, params: { user: user_params }

        expect(response).to redirect_to(root_path)
        expect(user_creation_request).to have_been_made
      end
    end

    context 'when user registration fails' do
      it 'does not create a user and sets a flash error message' do
        post :create, params: { user: invalid_params }

        expect(user_creation_request).not_to have_been_made
        expect(controller.flash[:error]).to eq('Sign-up failed.')
      end
    end
  end
end
