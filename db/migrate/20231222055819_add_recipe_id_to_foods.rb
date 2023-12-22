class AddRecipeIdToFoods < ActiveRecord::Migration[7.1]
  def change
    add_reference :foods, :recipe, null: false, foreign_key: true
  end
end
