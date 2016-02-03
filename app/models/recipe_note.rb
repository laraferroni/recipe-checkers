class RecipeNote < ActiveRecord::Base

	belongs_to :user
	belongs_to :recipe_revision



end
