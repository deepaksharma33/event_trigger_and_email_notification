# spec/controllers/users/events_controller_spec.rb

require 'rails_helper'

RSpec.describe Users::EventsController, type: :controller do
  let(:user) { create(:user) }

  describe 'POST #create' do
    context 'when creating an event successfully' do
      before do
        # Stub the iterable_service's create_event method to return a success response
        allow_any_instance_of(IterableService).to receive(:create_event)
          .and_return("code": 200, "message": "Event created successfully")

          stub_request(:post, "http://api.iterable.com:443/api/email/target").
          with(
            body: "{\"email\":\"#{user.email}\",\"eventName\":\"B\"}",
            headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Api-Key'=>'test123',
            'Content-Type'=>'application/json',
            'Host'=>'api.iterable.com',
            'User-Agent'=>'Ruby'
            }).
          to_return(status: 200, body: "", headers: {})
      end

      it 'creates an event and sends an email if conditions are met' do
        post :create, params: { event_name: 'B', user_id: user.id }

        expect(controller.flash[:message]).to eq("Iterable Event for #{user.email} created successfully.")
      end

      it 'creates an event but does not send an email if conditions are not met' do
        post :create, params: { event_name: 'A', user_id: user.id }

        expect(controller.flash[:message]).to eq("Iterable Event for #{user.email} created successfully.")
      end
    end

    context 'when event creation fails' do
      before do
        allow_any_instance_of(IterableService).to receive(:create_event).and_return("code": 422, "error": "Event creation failed")
      end

      it 'does not send an email and sets a flash error message' do
        post :create, params: { event_name: 'B', user_id: user.id }

        expect(controller.flash[:error]).to eq('Iterable event creation failed.')
      end
    end
  end
end
