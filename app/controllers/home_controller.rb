class HomeController < ApplicationController

  def index
    @current_lots = AuctionLot.where("start_date < ?", "#{Date.today}").approved
    @future_lots = AuctionLot.where("start_date > ?", "#{Date.today}").approved
  end

end
