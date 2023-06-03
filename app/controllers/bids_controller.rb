class BidsController < ApplicationController
  before_action :set_auction_lot, only: [:new, :create]
  before_action :user_only, only: [:new]
  before_action :block_restricted_user, only: [:new]
  before_action :not_signed_in, only: [:new]

  def new
    @bid = Bid.new
  end

  def create
    @bid = Bid.new(bid_params)
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

  def set_auction_lot
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
  end

end
