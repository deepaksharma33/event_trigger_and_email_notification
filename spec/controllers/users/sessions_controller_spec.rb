require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  let(:user) { create(:user) }

  before do
    # Set up the Devise mapping for the user model.
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    context 'with valid credentials' do
      it 'signs in the user' do
        post :create, params: { user: { email: user.email, password: user.password } }

        expect(response).to redirect_to(root_path)
        expect(controller.flash[:notice]).to be_present
      end
    end

    context 'with invalid credentials' do
      it 'does not sign in the user' do
        post :create, params: { user: { email: 'invalid@example.com', password: 'invalid_password' } }

        expect(response).not_to have_http_status(:success)
      end
    end
  end
end
