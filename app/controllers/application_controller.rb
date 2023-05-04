class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :danger, :info, :warning, :success, :messages


  def admin_only
    unless current_user.try(:admin?)
      flash[:danger] = 'Você não tem permissão para acessar este recurso'
      redirect_to root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :cpf, :admin])
  end

end
