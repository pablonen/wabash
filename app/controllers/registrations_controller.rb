class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:password, :password_confirmation, :handle, :email)
  end
end
