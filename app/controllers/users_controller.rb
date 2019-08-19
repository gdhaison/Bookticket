class UsersController < ApplicationController
  before_action :authenticate_user!

  def show; end

  def edit; end

  def update
    if current_user.update user_params
      bypass_sign_in(current_user)
      flash[:success] = "Profile updated"
      redirect_to user_path
    else
      render :edit
    end
  end

  private

  def user_params
    if params[:user][:password].blank?
      params.require(:user).permit(:full_name, :phone_number, :email, :address)
    else
      params.require(:user).permit(:full_name, :phone_number, :email, :address, :password,
                                   :password_confirmation)
    end
  end
end
