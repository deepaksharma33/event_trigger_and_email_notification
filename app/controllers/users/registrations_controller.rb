class Users::RegistrationsController < Devise::RegistrationsController
  extend ResponseHelper

  def create
    super do |user|
      if user.persisted?
        iterable_service = IterableService.new(user)
        response = iterable_service.create_user

        handle_response(response,
                        "Iterable user created successfully.",
                        "Iterable user creation failed.")
      else
        flash_error("Sign-up failed.")
      end
    end
  end
end
