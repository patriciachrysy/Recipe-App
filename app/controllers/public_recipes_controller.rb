class PublicRecipesController < ApplicationController
  def index
    @public_recipes = Recipe.public_recipes
    @total_food_items = @public_recipes.map { |recipe| recipe.foods.count }.sum
    @total_price = @public_recipes.map { |recipe| recipe.foods.sum(:price) }.sum
  end
end
