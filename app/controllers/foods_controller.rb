class FoodsController < ApplicationController
    before_action :authenticate_user!

    def index
        @foods = current_user.foods
    end

    def new
        @food = Food.new
    end

    def create
        @food = Food.new(food_params)
        @food.user = current_user
        authorize! :create, @food

        if @food.save
            redirect_to foods_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @food = Food.find(params[:id])
    end

    def update
        @food = Food.find(params[:id])
        authorize! :update, @food

        if @food.update(food_params)
            redirect_to foods_path
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @food = Food.find(params[:id])
        authorize! :destroy, @food
        @food.destroy
        redirect_to foods_path, status: :see_other
    end
    
    private

    def food_params
        params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
    end
end