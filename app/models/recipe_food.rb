class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.missing_food(user_id)
    joins(recipe: :user)
      .joins("LEFT JOIN foods ON foods.id = recipe_foods.food_id AND foods.user_id = #{user_id}")
      .where(users: { id: user_id })
      .where(foods: { id: nil })
  end
end
