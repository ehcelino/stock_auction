class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_blocked_user, only: [:create]
  # before_action :show_blocked_banner
  add_flash_types :danger, :info, :warning, :success, :messages


  def admin_only
    unless current_user.try(:admin?)
      flash[:danger] = 'Você não tem permissão para acessar este recurso'
      redirect_to root_path
    end
  end

  def user_only
    if current_user.try(:admin?)
      flash[:danger] = 'Esta função não é permitida para administradores'
      redirect_to (request.referer || root_path)
    end
  end

  # def show_blocked_banner
  #   user_signed_in? && current_user.blocked?
  # end

  # helper_method :show_blocked_banner

  def show_blocked_banner?
    session[:blocked] || (current_user.blocked? if user_signed_in?)
  end

  helper_method :show_blocked_banner?

  protected

  def set_blocked_user
    if user_signed_in?
      current_user.block_user
      if current_user.status == "blocked"
        # flash[:danger] = 'Seu usuário está bloqueado para as funções do site. Fale com seu administrador.'
        session[:blocked] = true
      else
        session[:blocked] = false
      end
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :cpf, :admin])
  end

end
