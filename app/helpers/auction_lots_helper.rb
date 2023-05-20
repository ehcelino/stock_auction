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

end
