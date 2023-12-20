class RecipesController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!, except: %i[index show]
  before_action :set_recipe, only: %i[show destroy]

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def public_recipes
    @public_recipes = Recipe.public_recipes
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_url, notice: 'Recipe was successfully destroyed.'
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :photo, :steps, :preparation_time, :cooking_time, :description, :public,
                                   :user)
  end
end
