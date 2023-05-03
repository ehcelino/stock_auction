class ItemsController < ApplicationController
  before_action :authenticate_user!

  def new
    @item = Item.new
    @categories = Category.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "Item cadastrado com sucesso"
      redirect_to root_path
    else
      flash.now[:danger] = "Não foi possível cadastrar o item"
      @categories = Category.all
      render :new
    end
  end



  private

  def item_params
    params.require(:item).permit(:name, :description, :weight, :width, :height, :depth, :category_id, :code, :image)
  end
end
