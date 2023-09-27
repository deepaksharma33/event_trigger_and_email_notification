class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |user|
      if user.persisted?
        iterable_service = IterableService.new(user)
        iterable_service.create_user
      else
        flash[:error] = "Unable to sign-up"
      end
    end
  end
end
