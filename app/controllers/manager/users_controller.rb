module Manager
  class UsersController < Manager::BaseController
    skip_before_action :verify_authenticity_token

    def index
      @users = User.page params[:page]
    end

    def update
      @users = User.page params[:page]
      user = User.find params[:id]
      if !user.deactivated
        user.update(deactivated: true)
      else
        user.update(deactivated: false)
      end
    end

    private

    def user_params
      params.require(:user).permit(:deactivated)
    end
  end
end
