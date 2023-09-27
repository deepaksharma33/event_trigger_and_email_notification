class Users::SessionsController < Devise::SessionsController
  extend FlashHelper

  layout "application"

  def new
    super
  end

  def create
    super do |user|
      if user.persisted?
        # TODO: add flash message if required
      else
        flash_error("Sign-in failed.")
      end
    end
  end
end
