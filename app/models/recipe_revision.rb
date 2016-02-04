class RecipeRevision < ActiveRecord::Base

	belongs_to :recipe
	has_many :recipe_ratings
	has_many :recipe_notes
	has_many :photos, :as => :assetable
  
  attr_accessor :name

	def name
		name = self.version_number
	end


	def has_comments(user)
		self.recipe_ratings.where("user_id = ?", user.id)
	end

	def body_by_lines
		lines = self.recipe_body.split(/\r?\n/)


		Hash[ lines.each_with_index.map{ |c,i| [i,Hash["text"=>c,"comment"=>self.comments_by_line(i)]]} ]

	end


	def comments_by_line(line_id)
		self.recipe_notes.where("line_id = ? AND hide = ?", line_id, false)
	end

end
