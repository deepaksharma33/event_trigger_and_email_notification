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
        flash_error("Sign-in failed.")
      end
    end
  end

  private

  def flash_error(err)
    flash[:error] = err
  end
end
