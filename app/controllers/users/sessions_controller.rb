class Users::SessionsController < Devise::SessionsController
  layout "application"

  def new
    super
  end

  def create
    super do |user|
      if user.persisted?
        # TODO: add flash message if required
      else
        flash[:error] = "Unable to sign-in"
      end
    end
  end
end
