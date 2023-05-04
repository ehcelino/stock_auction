class HomeController < ApplicationController

  def index
    @current_lots = AuctionLot.where("start_date < ?", "#{Date.today}")
    @future_lots = AuctionLot.where("start_date > ?", "#{Date.today}")
  end

end
