class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,  :omniauthable

  has_many :authentications, class_name: 'UserAuthentication', dependent: :delete_all
  has_one :user_preference

  has_many :projects
  has_many :authored_recipes, class_name: 'Recipe'
  has_many :recipe_revisions, through: :recipes
  has_many :recipe_ratings

  has_many :tester_recipes
  has_many :recipes, through: :tester_recipes



  attr_accessor :name

	def name
		name = []
		name << self.first_name if self.first_name.present?
		name << self.last_name if self.last_name.present?
		name.join(" ")
	end


  def pending_approval(recipe_id)
    recipe = Recipe.find(recipe_id)
    if !self.white_listed(recipe)

      TesterRecipe.where("recipe_id = ? and user_id = ? and approved = ?", recipe_id, self.id, false).last.present?  
    else
      false
    end
  end

  def approved_for(recipe_id)
    recipe = Recipe.find(recipe_id)
    
    if !self.white_listed(recipe)
      TesterRecipe.where("recipe_id = ? and user_id = ? and approved = ?", recipe_id, self.id, true).last.present?
    else
      true
    end

  end

  def currently_testing(recipe_id)
    TesterRecipe.where("recipe_id = ? and user_id = ?", recipe_id, self.id).last.present?
  end

  def white_listed(recipe)
    AuthorWhitelist.where("user_id = ? and tester_id = ?", recipe.user.id, self.id).last.present?
  end

  def black_listed(recipe)
    AuthorBlacklist.where("user_id = ? and tester_id = ?", recipe.user.id, self.id).last.present?
  end

  def rev_rating(recipe_revision)
    rating = recipe_revision.recipe_ratings.where("user_id = ?", self.id).last
    if !rating.present?
      rating = RecipeRating.new
      rating.recipe_revision_id = recipe_revision.id
      rating.user_id = self.id
    end
    rating

  end

  def reviewer_rating
    ratings = self.recipe_ratings.where("reviewer_rating > ?", 0)
    helpfulness = ratings.map(&:reviewer_rating).inject(0, :+)
    helpfulness/ratings.count
  end

end
