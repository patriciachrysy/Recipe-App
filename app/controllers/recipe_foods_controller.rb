class RecipeFoodsController < ApplicationController
    before_action :authenticate_user!

    def new
        @recipe_food = RecipeFood.new
    end

    def create
        @recipe_food 
    end

    private
    def recipe_food_params
        params.require(:recipe_food).permit(:food, :quantity)
    end
end