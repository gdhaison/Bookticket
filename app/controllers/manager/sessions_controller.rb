module Manager
  class SessionsController < Devise::SessionsController
    layout "layoutlogin"
    skip_before_action :verify_authenticity_token

    def after_sign_in_path_for _resource
      manager_root_path
    end

    def after_sign_out_path_for resource
      stored_location_for(resource) || new_admin_session_path
    end
  end
end
