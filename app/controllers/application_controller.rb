class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_blocked_user, only: [:create]
  add_flash_types :danger, :info, :warning, :success, :messages


  def admin_only
    unless current_user.try(:admin?)
      flash[:danger] = 'Você não tem permissão para acessar este recurso'
      redirect_to root_path
    end
  end

  protected

  def set_blocked_user
    if user_signed_in?
      current_user.block_user
      flash[:danger] = 'Seu usuário está bloqueado para as funções do site. Fale com seu administrador.' if current_user.status == "blocked"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :cpf, :admin])
  end

end
