class CreateTesterRecipes < ActiveRecord::Migration
  def change


  	create_table :projects do |t|
    	t.references :user
    	t.string :name
    	
      t.timestamps
  	end

    create_table :recipes do |t|
    	t.references :project
    	t.references :user
    	t.string :name
    	
      t.timestamps
    end

    create_table :recipe_revisions do |t|
    	t.references :recipe
    	t.integer :version_number
    	t.text :recipe_servings
    	t.text :recipe_body
    	t.text :notes_from_author
    	t.timestamps
    end

    create_table :tester_recipes do |t|
    	t.references :user
    	t.references :recipe
      t.timestamps
    end

    create_table :recipe_ratings do |t|
    	t.references :user
    	t.references :recipe_revision
    	t.integer :overall_satisfaction
    	t.integer :would_make_again
    	t.string :servings_made
    	t.string :time_to_make
    	t.text :overall_notes
      t.timestamps
    end   

    create_table :recipe_notes do |t|
    	t.references :user
    	t.references :recipe_revision
    	t.text :notes
    	t.integer :start_char
    	t.integer :end_char
      t.timestamps
    end

  	create_table :assets do |t|
      t.string :type
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.string :attachment_file_size
      t.string :orientation
      t.datetime :attachment_updated_at

      t.references :assetable, polymorphic: true, index: true
      t.timestamps
    end

  end
end
