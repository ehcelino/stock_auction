class LotItemsController < ApplicationController

  def new
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
    @items = Item.where.missing(:lot_items)
    @lot_item = LotItem.new
  end

  def create
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
    @auction_lot.lot_items.create(lot_item_params)
    redirect_to @auction_lot, notice: 'Item adicionado com sucesso'
  end

  private

  def lot_item_params
    params.require(:lot_item).permit(:item_id)
  end
end
