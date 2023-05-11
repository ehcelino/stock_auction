class AuctionLotsController < ApplicationController
  before_action :admin_only, only: [:new, :create, :index]
  before_action :set_auction_lot, only: [:show, :approved, :closed, :canceled, :favorite, :unfavorite, :edit, :update]


  def new
    @auction_lot = AuctionLot.new
  end

  def create
    @auction_lot = AuctionLot.new(auction_lot_params)
    @auction_lot.created_by = current_user.id
    if @auction_lot.save
      flash[:success] = 'Lote criado com sucesso'
      return redirect_to @auction_lot
    end
    flash.now[:danger] = 'Lote inválido'
    render :new
  end

  def edit
  end

  def update
    if @auction_lot.update(auction_lot_params)
      flash[:success] = 'Lote atualizado com sucesso'
      return redirect_to @auction_lot
    end
    flash.now[:danger] = 'Lote inválido'
    render :edit
  end

  def index
    @auction_lots = AuctionLot.pending
  end

  def show
  end

  def approved
    user = User.find(@auction_lot.created_by)
    if current_user == user
      flash[:danger] = 'Um lote não pode ser aprovado pelo usuário que o criou'
      return redirect_to @auction_lot
    elsif @auction_lot.items.count == 0
      flash[:danger] = 'Um lote não pode ser aprovado sem itens'
      return redirect_to @auction_lot
    else
      @auction_lot.approved_by = current_user.id
      @auction_lot.save
      @auction_lot.approved!
      flash[:success] = 'Este lote foi aprovado com sucesso'
      redirect_to @auction_lot
    end
  end

  def expired
    @auction_lots = AuctionLot.expired.approved
  end

  def closed
    @auction_lot.closed!
    flash[:success] = 'Lote finalizado com sucesso'
    redirect_to @auction_lot
  end

  def canceled
    @auction_lot.release_items
    @auction_lot.canceled!
    flash[:success] = 'Lote cancelado com sucesso'
    redirect_to @auction_lot
  end

  def closed_list
    @auction_lots = AuctionLot.closed
  end

  def favorite
    Favorite.create!(user_id: current_user.id, auction_lot_id: @auction_lot.id)
    flash[:success] = 'Lote adicionado aos favoritos'
    redirect_to @auction_lot
  end

  def unfavorite
    favorites = Favorite.where(user_id: current_user.id, auction_lot_id: @auction_lot.id)
    favorites[0].destroy
    flash[:success] = 'Lote removido dos favoritos'
    redirect_to @auction_lot
  end

  private

  def auction_lot_params
    params.require(:auction_lot).permit(:code, :start_date, :end_date, :min_bid_amount, :min_bid_difference, :status, :created_by, :approved_by)
  end

  def set_auction_lot
    @auction_lot = AuctionLot.find(params[:id])
  end
end
