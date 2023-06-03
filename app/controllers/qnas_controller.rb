class QnasController < ApplicationController
  before_action :admin_only, only: [:index, :answer]
  before_action :user_only, only: [:new]
  before_action :block_restricted_user, only: [:new]
  before_action :not_signed_in, only: [:new]

  def new
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
    @qna = Qna.new
  end

  def create
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
    @qna = Qna.new(qna_params)
    @qna.auction_lot_id = @auction_lot.id
    if @qna.save
      flash[:success] = 'Sua pergunta foi registrada'
      return redirect_to @auction_lot
    end
    flash[:danger] = 'Ocorreu um erro'
    render :new
  end

  def index
    @qnas = Qna.all
  end

  def answer
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
    @qna = Qna.find(params[:id])
    @qna.user_id = current_user.id
    @qna.answer = params[:answer]
    # if @qna.save
    #   flash[:success] = 'Resposta gravada com sucesso'
    #   redirect_to qna_index_path
    # end
  end

  def answered
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
    @qna = Qna.find(params[:id])
    @qna.user_id = current_user.id
    @qna.answer = params[:answer]
    if @qna.save
      flash[:success] = 'Resposta gravada com sucesso'
      redirect_to qna_index_path
    end
  end

  def hidden
    @qna = Qna.find(params[:id])
    @qna.hidden!
    flash[:success] = 'Pergunta oculta por administrador'
    redirect_to qna_index_path
  end

  def approved
    @qna = Qna.find(params[:id])
    @qna.approved!
    flash[:success] = 'Pergunta restaurada por administrador'
    redirect_to qna_index_path
  end

  private

  def qna_params
    params.require(:qna).permit(:user_id, :question, :answer, :auction_lot_id, :status)
  end

end
