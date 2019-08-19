module Manager
  class BaseController < ApplicationController
    layout "admin"

    before_action :authenticate_admin!
    skip_before_action :store_user_location!
    before_action :set_notification

    def set_notification
      @notifications = Notification.all.reverse
    end
  end
end
