class AuctionLotsController < ApplicationController
  before_action :admin_only, only: [:new, :create, :index]


  def new
    @auction_lot = AuctionLot.new
  end

  def create
    @auction_lot = AuctionLot.new(auction_lot_params)
    @auction_lot.created_by = current_user.id
    if @auction_lot.save
      flash[:success] = 'Lote criado com sucesso'
      return redirect_to @auction_lot
    end
    flash.now[:danger] = 'Lote inválido'
    render :new
  end

  def index
    @auction_lots = AuctionLot.pending
  end

  def show
    @auction_lot = AuctionLot.find(params[:id])
  end

  def approved
    @auction_lot = AuctionLot.find(params[:id])
    user = User.find(@auction_lot.created_by)
    if current_user == user
      flash[:danger] = 'Um lote não pode ser aprovado pelo usuário que o criou'
      return redirect_to @auction_lot
    elsif @auction_lot.items.count == 0
      flash[:danger] = 'Um lote não pode ser aprovado sem itens'
      return redirect_to @auction_lot
    else
      @auction_lot.approved_by = current_user.id
      @auction_lot.save
      @auction_lot.approved!
      flash[:success] = 'Este lote foi aprovado com sucesso'
      redirect_to @auction_lot
    end
  end

  private

  def auction_lot_params
    params.require(:auction_lot).permit(:code, :start_date, :end_date, :min_bid_amount, :min_bid_difference, :status, :created_by, :approved_by)
  end

end
