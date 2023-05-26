class CategoriesController < ApplicationController
  before_action :admin_only, only: [:new, :create, :index]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Categoria criada com sucesso'
      return redirect_to categories_path
    end
    flash.now[:danger] = 'Houve um erro na criação da categoria'
    render :new
  end

  def index
    @categories = Category.all
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
