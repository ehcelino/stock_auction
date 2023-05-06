class BidsController < ApplicationController

  def new
    @bid = Bid.new
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
  end

  def create
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
    @bid = Bid.new(bid_params)
    # if @bid.value < @auction_lot.minimum_value
    #   flash.now[:danger] = 'Valor menor que o mínimo necessário para o lance'
    #   render :new
    # end
    @bid.auction_lot = @auction_lot
    @bid.user = current_user
    if @bid.save
      flash[:success] = 'Lance registrado com sucesso'
      return redirect_to @auction_lot
    end
    flash[:danger] = 'Não foi possível registrar seu lance'
    render :new
  end

  private

  def bid_params
    params.require(:bid).permit(:value)
  end

end
