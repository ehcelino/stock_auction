class AuctionLotsController < ApplicationController
  before_action :admin_only, only: [:new, :create]


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

  def show
    @auction_lot = AuctionLot.find(params[:id])
  end

  private

  def auction_lot_params
    params.require(:auction_lot).permit(:code, :start_date, :end_date, :min_bid_amount, :min_bid_difference, :status, :created_by, :approved_by)
  end

end
