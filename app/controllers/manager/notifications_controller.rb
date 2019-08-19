module Manager
  class NotificationsController < Manager::BaseController
    def check_read
      @notification = Notification.find(params[:id])
      @notification.update read: true
      redirect_to manager_orders_path
    end
  end
end
