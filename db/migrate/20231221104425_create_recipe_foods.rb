class CreateRecipeFoods < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_foods do |t|
      t.references :food, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.float :quantity

      t.timestamps
    end
  end
end
