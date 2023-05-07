class LotItemsController < ApplicationController
  before_action :admin_only, only: [:new, :create]
  before_action :set_auction_lot, only: [:new, :create]

  def new
    @items = Item.where.missing(:lot_items)
    if @items.count == 0
      flash[:danger] = 'Não existem itens para anexar ao lote'
      return redirect_to @auction_lot
    end
    @lot_item = LotItem.new
  end

  def create
    @auction_lot.lot_items.create(lot_item_params)
    redirect_to @auction_lot, notice: 'Item adicionado com sucesso'
  end

  private

  def lot_item_params
    params.require(:lot_item).permit(:item_id)
  end

  def set_auction_lot
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
  end

end
