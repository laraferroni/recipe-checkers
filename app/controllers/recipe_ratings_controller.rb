class RecipeRatingsController < ApplicationController

  before_action :set_recipe_rating, only: [:show, :edit, :update, :remove, :destroy, :dashboard]

  before_action :authenticate_user!


def index
    @recipe_ratings = RecipeRating.all

  end

  def show

  end

  def dashboard

  end

  def new
    @recipe_rating = RecipeRating.new

  end

  def edit
  end

  def create
  	@recipe_rating = RecipeRating.new(recipe_rating_params)
		@recipe_rating.save

    respond_to do |format|
      format.js
    end    

  end

  def update
    @recipe_rating.update(recipe_rating_params)
    attachment = params[:photo]
    if !attachment.nil?
      photo_params = { "attachment" => attachment}
      @recipe_rating.photos.new(photo_params).save!
    end
  end

  def add_photo
    set_recipe_rating
    attachment = params[:imageUpload]
    if !attachment.nil?
      photo_params = { "attachment" => attachment}
      @recipe_revision.photos.new(photo_params).save!
    end
  end


  def remove
  	@recipe_rating.hide = true
  	@recipe_rating.save!
  	render :text => "", status:200
  end

  def destroy
    @recipe_rating.destroy

  end

  def helpfulness
    set_recipe_rating
    @recipe_rating.reviewer_rating = params["reviewer_rating"]
    @recipe_rating.save!
    render :text => "", status:200
  end

  private
    def set_recipe_rating
        @recipe_rating = RecipeRating.find(params[:id])
    end

    def recipe_rating_params
      params.require(:recipe_rating).permit(:user_id, :recipe_revision_id, :overall_satisfaction, :would_make_again, :servings_made, :time_to_make, :overall_notes, :reviewer_rating)
    end
end