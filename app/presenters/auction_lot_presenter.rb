class AuctionLotPresenter < SimpleDelegator
  # attr_reader :auction_lot, :code
  attr_reader :auction_lot

  def initialize(auction_lot)
    @auction_lot = auction_lot
    # @code = auction_lot.code
    super(auction_lot)
  end

  def __getobj__
    @auction_lot
  end

  def eql?(target)
    target == self || product.eql?(target)
  end

  def actions
    if ApplicationController.user_logged? && current_user.admin? && @auction_lot.status == "pending"
      helpers.content_tag(:div, class:"my-3") do
        helpers.content_tag(:div, class:"d-flex gap-3") do
          link_to('Adicionar itens', new_auction_lot_lot_item_path(@auction_lot), class:"btn btn-secondary")
          button_to('Aprovar lote', approved_auction_lot_path, class:"btn btn-secondary")
        end
      end
    end
  end

end
