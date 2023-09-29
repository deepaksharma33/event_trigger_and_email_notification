class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |user|
      if user.persisted?
        iterable_service = IterableService.new(user)
        response = iterable_service.create_user

        handle_response(response,
                        "Iterable user created successfully.",
                        "Iterable user creation failed.")
      else
        flash[:error] = "Sign-up failed."
      end
    end
  end

  private

  def handle_response(response, success_message, error_message)
    response_code = response[:code]&.to_i || response.code.to_i

    response_code == 200 ? flash[:message] = success_message : flash[:error] = error_message
  end
end
