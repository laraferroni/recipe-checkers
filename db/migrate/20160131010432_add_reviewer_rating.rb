class AddReviewerRating < ActiveRecord::Migration
  def change
  	add_column :recipe_ratings, :reviewer_rating, :integer, default: 0
  end
end
