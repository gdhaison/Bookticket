module Manager
  class ScannersController < Manager::BaseController
    skip_before_action :verify_authenticity_token

    def new
      respond_to do |format|
        format.html
        format.js
      end
    end
  end
end
