class AddRecipeNoteFields < ActiveRecord::Migration
  def change
  	add_column :recipe_notes, :line_id, :integer, index: true
  	add_column :recipe_notes, :hide, :boolean, default: false, index: true

		add_column :recipes, :recipe_servings, :text
		add_column :recipes, :number_of_testers, :integer, default: 3
		add_column :recipes, :complete, :boolean, default: false
		add_column :recipes, :test_deadline, :datetime
  	
  	add_column :recipe_revisions, :number_of_testers, :integer, default: 3
		add_column :recipe_revisions, :ready_to_test, :boolean, default: false

		add_column :projects, :complete, :boolean, default: false, index: true

		add_column :tester_recipes, :approved, :boolean, default: false, index: true

		add_column :projects, :terms, :text
		add_column :projects, :test_deadline, :datetime
		
		add_column :users, :tester_bio, :text
		add_column :users, :author_bio, :text

  end
end
