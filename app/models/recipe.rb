class Recipe < ActiveRecord::Base

	belongs_to :user
	belongs_to :project
	has_many :recipe_revisions
	has_many :recipe_ratings, through: :recipe_revisions
	has_many :tester_recipes
	has_many :users, through: :tester_recipes
	has_many :recipe_notes, through: :recipe_revisions


	def available_test_list_name

		list_item = []
		list_item << self.name if self.name.present?
		if self.project.test_deadline.present?
			list_item << "due in #{self.project.days_to_complete} days" 
		end
		list_item.join(" | ")
	end

	def draft
		self.recipe_revisions.where("ready_to_test = ?", false).last
	end

	def ready_to_test
		self.recipe_revisions.where("ready_to_test = ?", true).last.present?
	end

	def last_promoted
		self.recipe_revisions.where("ready_to_test = ?", true).last
	end

	def versions_available
		self.recipe_revisions.where("ready_to_test = ?", true)
	end

	def tester_count
		self.tester_recipes.count
	end


	def tester_recipes_with_email
		self.tester_recipes.select{|tr| tr.user.email.present?}
	end

	def self.recipes_available
		recipes = Recipe.where("complete != ?", true)
		available_recipes = recipes.select{ |r| r.recipe_revisions.where("ready_to_test = ?", true).last.present? }
		available_recipes= available_recipes.select{ |r| r.tester_count < r.number_of_testers}	
		return available_recipes
	end


	def average_overall_rating
		ratings = self.recipe_ratings.where("overall_satisfaction IS NOT ?", nil)
		if ratings.present?
			sat_total = ratings.map(&:overall_satisfaction).inject(0, :+)
			sat_total/ratings.count
		else
			0
		end
	end

	def average_would_make_again
		ratings = self.recipe_ratings.where("would_make_again IS NOT ?", nil)
		if ratings.present?
			sat_total = ratings.map(&:would_make_again).inject(0, :+)
			sat_total/ratings.count
		else
			0
		end
	end

end