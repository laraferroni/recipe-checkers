class AuthorNotes < ActiveRecord::Migration
  def change
  	  	add_column :recipe_revisions, :private_notes, :text
  	  	add_column :users, :website, :string
  	  	change_column :recipe_ratings, :would_make_again, :integer, default: 0
  	  	change_column :recipe_ratings, :overall_satisfaction, :integer, default: 0
  end
end
