class BlockedCpfsController < ApplicationController
  before_action :admin_only, only: [:index, :new, :create, :destroy]

  def index
    @blocked_cpfs = BlockedCpf.all
  end

  def new
    @blocked_cpf = BlockedCpf.new
  end

  def create
    @blocked_cpf = BlockedCpf.new(blocked_cpf_params)
    if @blocked_cpf.save
      flash[:success] = 'CPF adicionado à lista de bloqueio'
      return redirect_to blocked_cpfs_path
    end
    flash[:danger] = 'Ocorreu um erro'
    render :new
  end

  def destroy
    @blocked_cpf = BlockedCpf.find(params[:id])
    @blocked_cpf.destroy
    flash[:success] = 'CPF retirado da lista de bloqueio'
    redirect_to blocked_cpfs_path
  end

  private

  def blocked_cpf_params
    params.require(:blocked_cpf).permit(:cpf)
  end

end
