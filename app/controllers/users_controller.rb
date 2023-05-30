class UsersController < ApplicationController

  def show
    if !user_signed_in?
      flash[:danger] = 'É necessário estar logado.'
      return redirect_to root_path
    end
  end

end
