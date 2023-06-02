module UsersHelper

  def has_winning_lots(current_user)
    if current_user.winning_lots.count > 0
      var_delivered = current_user.winning_lots.select {|x| !x.delivered?}.count
      if var_delivered != 0
        content_tag(:span, "#{var_delivered}", class:"position-absolute top-20 start-100 translate-middle badge rounded-pill bg-danger", id:"badge" )
      end
    end
  end

  def list_winning_lots(current_user)
    if current_user.winning_lots.count > 0
      current_user.winning_lots.map do |wl|
        if !wl.delivered?
          link_to(wl, class:"clean-link") do
            content_tag(:h5, "Lote: #{wl.code}")
          end +
          content_tag(:p, "Valor: #{number_to_currency(wl.bids.last.value)}")
        end
      end.join('').html_safe
    end
  end

end
