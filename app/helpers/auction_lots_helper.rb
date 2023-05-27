module AuctionLotsHelper

  def can_i_bid?(lot)
    user_signed_in? && lot.biddable? && !current_user.blocked?
  end

  def can_i_fav?(lot)
    user_signed_in? && !current_user.blocked? && lot.questionable_and_favoritable?
  end

  def can_i_edit?(lot)
    user_signed_in? && current_user.admin? && lot.editable?
  end

  def can_i_ask_question?(lot)
    user_signed_in? && !current_user.blocked? && lot.questionable_and_favoritable?
  end

  def expired_with_bids?(lot)
    user_signed_in? && lot.expired? && current_user.admin? && !lot.closed? && !lot.canceled? && lot.bids.count > 0
  end

  def is_lot_expired?(lot)
    user_signed_in? && lot.expired? && current_user.admin? && !lot.closed? && !lot.canceled?
  end

  def action_pending(auction_lot)
    if user_signed_in? && current_user.admin? && auction_lot.status == "pending"
      content_tag(:div, class:"my-3") do
        content_tag(:div, class:"d-flex gap-3") do
          link_to('Adicionar itens', new_auction_lot_lot_item_path(auction_lot), class:"btn btn-secondary") +
          button_to('Aprovar lote', approved_auction_lot_path, class:"btn btn-secondary")
        end
      end
    end
  end

  def action_bid(auction_lot)
    if can_i_bid?(auction_lot)
      content_tag(:div, class:'my-3') do
        link_to('Dar um lance', new_auction_lot_bid_path(auction_lot), class:"btn btn-danger")
      end
    end
  end

  def action_favorite(auction_lot)
    if auction_lot.questionable_and_favoritable? && user_signed_in?
      if current_user.is_favorite?(auction_lot)
        content_tag(:div, button_to("Remover dos favoritos", unfavorite_auction_lot_path(auction_lot), method: :delete, class:"btn btn-secondary"), class:"my-3" )

      else
        content_tag(:div, button_to("Adicionar aos favoritos", favorite_auction_lot_path(@auction_lot), method: :post, class:"btn btn-secondary"), class:"my-3")
      end
    end
  end

  def action_edit(auction_lot)
    if can_i_edit?(auction_lot)
      content_tag(:div, link_to("Editar lote", edit_auction_lot_path(auction_lot.id), class:"btn btn-secondary"), class:"my-3")
    end
  end

  def status_closed(auction_lot)
    if auction_lot.status == "closed"
      content_tag(:div, class:"my-3") do
        content_tag(:h3, class:"text-orange") do
          "Este lote foi finalizado. Usuário vencedor: #{auction_lot.users.last.name} - #{auction_lot.users.last.email}"
        end
      end
    end
  end

  def status_canceled(auction_lot)
    if auction_lot.status != "canceled"
      content_tag(:h3, 'Este lote ainda não possui itens cadastrados.')
    else
      content_tag(:h3, 'Este lote foi cancelado.', class:'text-orange')
    end
  end

end
