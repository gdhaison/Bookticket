class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search
  before_action :store_user_location!, if: :storable_location?

  protected

  def configure_permitted_parameters
    added_attrs = %i[name email password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def search
    @search = Movie.ransack
  end

  def after_sign_in_path_for resource
    stored_location_for(resource) || root_url
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end
end
