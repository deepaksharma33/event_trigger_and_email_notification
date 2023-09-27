class Users::EventsController < ApplicationController
  after_action :check_to_send_email, only: :create, if: :send_email?

  def create
    response = iterable_service.create_event

    handle_response(response,
                    "Iterable Event for #{@user.email} created successfully.",
                    "Iterable event creation failed.")
  end

  private

  def user
    @user ||= User.find(event_params[:user_id])
  end

  def iterable_service
    @iterable_service ||= IterableService.new(user, event_params[:event_name])
  end

  def event_params
    params.permit(:event_name, :user_id)
  end

  def check_to_send_email
    send_email
  end

  def send_email?
    event_params[:event_name] == "B" && flash[:error].blank?
  end

  def send_email
    response = iterable_service.send_email

    handle_response(response,
                    "Email sent to user with email #{@user.email} successfully.",
                    "Unable to send email.")
  end

  def handle_response(response, success_message, error_message)
    response_code = response[:code].to_i

    response_code == 200 ? flash[:message] = success_message : flash[:error] = error_message
  end
end
