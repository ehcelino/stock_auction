module AuctionLotsHelper

  def action_pending(auction_lot)
    if user_signed_in? && current_user.admin? && auction_lot.pending? && !auction_lot.expired?
      content_tag(:div, class:"my-3") do
        content_tag(:div, class:"d-flex gap-3") do
          link_to('Adicionar itens', new_auction_lot_lot_item_path(auction_lot), class:"btn btn-secondary") +
          button_to('Aprovar lote', approved_auction_lot_path, class:"btn btn-secondary")
        end
      end
    end
  end

  def action_bid(auction_lot)
    if user_signed_in? && auction_lot.biddable? && !current_user.blocked?
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
    if user_signed_in? && current_user.admin? && auction_lot.editable?
      content_tag(:div, link_to("Editar lote", edit_auction_lot_path(auction_lot.id), class:"btn btn-secondary"), class:"my-3")
    end
  end

  def action_ask(auction_lot)
    if user_signed_in? && !current_user.blocked? && auction_lot.questionable_and_favoritable?
      content_tag(:div, link_to("Fazer uma pergunta", new_auction_lot_qna_path(@auction_lot), class:"btn btn-secondary"), class:"mb-3")
    end
  end

  def action_deliver(auction_lot)
    if user_signed_in? && current_user.admin? && auction_lot.closed? && !auction_lot.delivered? && auction_lot.winner.present?
      content_tag(:div, button_to("Marcar como entregue", delivered_auction_lot_path(auction_lot), method: :post, class:"btn btn-secondary"), class:"my-3" )
    end
  end

  def action_new_user
    if !user_signed_in?
      link_to("Cadastre-se", new_user_registration_path) + " para ter acesso às funções do site."
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

  def status_expired(auction_lot)
    if user_signed_in? && auction_lot.expired? && current_user.admin? && !auction_lot.closed? && !auction_lot.canceled? && !auction_lot.delivered?
      content_tag(:h3, "Este lote está expirado. Foram feitos #{auction_lot.bids.count} lances.", class:"my-3") +
      content_tag(:div, class:"my-3") do
        if auction_lot.bids.count == 0
          button_to('Cancelar o lote', canceled_auction_lot_path(auction_lot), class:"btn btn-secondary")
        else
          button_to('Finalizar o lote', closed_auction_lot_path(auction_lot), class:"btn btn-secondary")
        end
      end
    end
  end

  def status_bids(auction_lot)
    if auction_lot.bids.present? && auction_lot.biddable?
      content_tag(:div, class: "mb-3 border rounded p-2 bids-board") do
        content_tag(:div) do
          content_tag(:h3, "Lances recebidos", class: "text-center")
        end +
        auction_lot.bids.map.with_index do |bid, idx|
          content_tag(:div, class: "mb-2") do
            if idx == (auction_lot.bids.size - 1)
              content_tag(:strong) do
                "#{l(bid.created_at.in_time_zone("America/Sao_Paulo"), format: :short)} - #{bid.user.name} - #{number_to_currency(bid.value)}".html_safe +
                content_tag(:span, " - Lance vencedor no momento", class: "text-danger")
              end
            else
              "#{l(bid.created_at.in_time_zone("America/Sao_Paulo"), format: :short)} - #{bid.user.name} - #{number_to_currency(bid.value)}".html_safe
            end
          end
        end.join('').html_safe
      end
    end
  end

  def status_expired_with_bids(auction_lot)
    if user_signed_in? && auction_lot.expired? && current_user.admin? && !auction_lot.canceled? && auction_lot.bids.count > 0
      content_tag(:div, class: "mb-3 border rounded p-2 bids-board") do
        content_tag(:div) do
          content_tag(:h3, "Histórico de lances", class: "text-center")
        end +
        auction_lot.bids.includes([:user]).map.with_index do |bid, idx|
          content_tag(:div, class: "mb-2") do
            if idx == (auction_lot.bids.size - 1)
              content_tag(:strong) do
                "#{l(bid.created_at.in_time_zone("America/Sao_Paulo"), format: :short)} - #{bid.user.name} - #{number_to_currency(bid.value)}".html_safe +
                content_tag(:span, " - Lance vencedor", class: "text-danger")
              end
            else
              "#{l(bid.created_at.in_time_zone("America/Sao_Paulo"), format: :short)} - #{bid.user.name} - #{number_to_currency(bid.value)}".html_safe
            end
          end
        end.join('').html_safe
      end
    end
  end

  def display_questions(auction_lot)
    if auction_lot.qnas.present?
      content_tag(:div, class:"mb-3") do
        content_tag(:h3, "Perguntas e respostas") +
        content_tag(:hr) +
        content_tag(:div, class:"mb-3") do
          auction_lot.qnas.map do |qna|
            if qna.status != 'hidden'
              content_tag(:p, "Pergunta: #{qna.question}") +
              content_tag(:p, "Resposta: #{qna.answer}") +
              if qna.user_id.present?
                content_tag(:p, "Respondida por: #{User.find(qna.user_id).email}")
              end +
              content_tag(:hr)
            end
          end.join('').html_safe
        end
      end
    end
  end

  def display_items_qtty(auction_lot)
    if auction_lot.items.present?
      content_tag(:span, "- Itens: #{auction_lot.items.count}")
    end
  end

  def display_time_to_begin(auction_lot)
    if auction_lot.start_date > Date.today
      content_tag(:strong, " em #{distance_of_time_in_words(Date.today, auction_lot.start_date)}", class:"text-primary")
    end
  end

  def display_time_to_end(auction_lot)
    if auction_lot.start_date <= Date.today && auction_lot.end_date > Date.today
      content_tag(:strong, " em #{distance_of_time_in_words(Date.today, auction_lot.end_date)}", class:"text-primary")
    end
  end

end
