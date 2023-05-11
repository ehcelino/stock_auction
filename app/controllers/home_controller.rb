class HomeController < ApplicationController

  def index
    @current_lots = AuctionLot.current.approved
    @future_lots = AuctionLot.future.approved
  end

  def search
    @query = params["query"]
    return @auction_lots if @query == ''
    @auction_lots = AuctionLot.where("code LIKE ?", "%#{@query}%")
    items = Item.where("name LIKE ?", "%#{@query}%").each {|item| item if item.auction_lots.present?}
    if items.present?
      other_lots = items.map { |x| x.auction_lots }
      other_lots.flatten!
      @auction_lots = @auction_lots + other_lots
    end
  end


end
