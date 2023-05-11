class ItemsController < ApplicationController
  before_action :admin_only, only: [:new, :create, :index, :edit, :update]
  before_action :set_item, only: [:edit, :update, :show]

  def new
    @item = Item.new
    @categories = Category.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "Item cadastrado com sucesso"
      redirect_to @item
    else
      flash.now[:danger] = "Não foi possível cadastrar o item"
      @categories = Category.all
      render :new
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    if @item.update(item_params)
      flash[:success] = 'Item atualizado com sucesso'
      return redirect_to @item
    end
    flash.now[:danger] = 'Falha na atualização'
    @categories = Category.all
    render :edit
  end


  def show
  end

  def index
    @items = Item.where.missing(:lot_items)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :weight, :width, :height, :depth, :category_id, :code, :image)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
