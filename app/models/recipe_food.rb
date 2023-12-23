class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :food, presence: true

  def self.missing_food(user_id)
    where_clause = <<-SQL
      recipes.user_id = #{user_id}
      AND foods.name NOT IN (SELECT name FROM foods WHERE foods.user_id = #{user_id})
    SQL

    joins(recipe: :user, food: :user)
      .where(where_clause)
  end
end
