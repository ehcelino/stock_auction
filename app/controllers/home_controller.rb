class HomeController < ApplicationController

  def index
    @current_lots = AuctionLot.current.approved
    @future_lots = AuctionLot.future.approved
  end

  def search
    @query = params["query"]
    if @query == ''
      flash.now[:danger] = 'Não é possível realizar uma busca vazia'
      return @auction_lots
    end
    @auction_lots = AuctionLot.where("code LIKE ?", "%#{@query}%")
    items = Item.where("name LIKE ?", "%#{@query}%").includes([:auction_lots])
    if items.present? && @query != ''
      other_lots = items.map { |x| x.auction_lots }
      other_lots.flatten!
      @auction_lots = @auction_lots + other_lots
    end
    @auction_lots = @auction_lots.select {|z| z.approved? || z.closed?}
  end


end
