class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[public_recipes]

  def index
    @recipes = current_user.recipes.includes({ recipe_foods: :food }, :user).all
  end

  def show
    @recipe = Recipe.includes({ recipe_foods: :food }, :user).find(params[:id])
  end

  def public_recipes
    @public_recipes = Recipe.includes({ recipe_foods: :food }, :user).public_recipes
  end

  def update_public_status
    @recipe = current_user.recipes.find(params[:id])
    authorize! :update, @recipe
    @recipe.update(public: !@recipe.public)

    redirect_to @recipe, notice: @recipe.public ? 'Recipe is now public.' : 'Recipe is now private.'
  end

  def new
    @recipe = current_user.recipes.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    authorize! :create, @recipe

    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    authorize! :destroy, @recipe

    @recipe.destroy

    redirect_to recipes_path, notice: 'Recipe was successfully destroyed.'
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :photo, :preparation_time, :cooking_time, :description)
  end
end
