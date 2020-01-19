class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: :create

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    if current_user.admin?
      flash[:success] = t "welcome_admin"
      redirect_to rails_admin_path
    else
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end

  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit :sign_in, keys: [:email, :password]
  end
end
