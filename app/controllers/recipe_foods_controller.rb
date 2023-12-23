class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.new
    @foods = Food.all
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.new(recipe_food_params)
    authorize! :update, @recipe

    if food_already_added?(@recipe_food.food, @recipe)
      flash[:alert] = 'This food has already been added to the recipe'
      @foods = Food.all
      render :new
    elsif @recipe_food.save
      flash[:notice] = "#{@recipe_food.food.name} ingredient was successfully added to the recipe"
      redirect_to recipe_path(@recipe)
    else
      flash[:alert] = 'The food could not be added to the recipe, please check the form and try again'
      @foods = Food.all
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])
    @foods = Food.all
  end

  def update
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])
    authorize! :update, @recipe

    if @recipe_food.update(recipe_food_params)
      flash[:notice] = 'The ingredient was successfully updated'
      redirect_to recipe_path(@recipe_food.recipe)
    else
      flash[:alert] = 'The ingredient could not be updated, please check the form and try again'
      @foods = Food.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])
    authorize! :update, @recipe

    @recipe_food.destroy
    flash[:notice] = 'The ingredient was successfully removed from the recipe'
    redirect_to recipe_path(@recipe), status: :see_other
  end

  def generate_shopping_list
    @shopping_items = RecipeFood.missing_food(current_user.id)
  end

  private

  def food_already_added?(food, recipe)
    return true if food.nil?

    RecipeFood.find_by(food_id: food.id, recipe_id: recipe.id)
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
