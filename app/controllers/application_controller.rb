class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller? # customer側の新規登録情報を保存

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path # admin側
    else
      new_customer_session_path # customer側
    end
  end

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admins_top_path # admin側
    when Customer
      root_path # customer側
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :country, :birthday, :visit_time])
  end
end
