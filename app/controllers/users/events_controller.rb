class Users::EventsController < ApplicationController
  around_create :send_email

  def create
    iterable_service.create_event
  end

  private

  def iterable_service
    user = User.find(event_params.user_id)

    @iterable_service ||= IterableService.new(user, event_params.event_name)
  end

  def event_params
    params.permit(:event_name, :user_id)
  end

  def send_email
    yield

    iterable_service.send_email if flash[:error].blank?
  end
end
