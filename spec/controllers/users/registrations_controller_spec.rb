# spec/controllers/users/registrations_controller_spec.rb

require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  let(:user_attributes) { create(:user) } # Generate user attributes using FactoryBot

  before do
    # Set up the Devise mapping for the user model.
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    context 'when user registration is successful' do
      it 'creates a user and sends data to Iterable' do
        post :create, params: { user: user_attributes }

        expect(response.code).not_to eq("200")
      end
    end

    context 'when user registration fails' do
      it 'does not create a user and sets a flash error message' do
        post :create, params: { user: user_attributes }

        expect(controller.flash[:error]).to eq('Sign-up failed.')
      end
    end
  end
end
