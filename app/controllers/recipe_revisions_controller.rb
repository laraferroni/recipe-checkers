class RecipeRevisionsController < ApplicationController

	before_action :authenticate_user!
  before_action :set_recipe_revision, only: [:show, :edit, :update, :destroy]

  respond_to(:html, :js)

  def index
    @recipe_revisions = Recipe.all

  end

  def show

  end

  def dashboard

  end

  def new
    @recipe_revision = Recipe.new

    if params["recipe_id"]
    	@recipe = RecipeRevision.find(params["recipe_id"])
	    @recipe_revision.recipe_id = @recipe.id
	    if @recipe.recipe_revisions.last.present?
		    @recipe_revision.version_number = @recipe.recipe_revisions.last.version_number+1
		    @recipe_revision.recipe_body = @recipe.recipe_revisions.last.body
  		else
  			@recipe_revision.version_number = 1
  		end
    end
  end

  def edit
  end

  def create
  	@recipe_revision = RecipeRevision.new(recipe_revision_params)
		@recipe_revision.save!
    respond_to do |format|
      logger.debug(format)

      format.js
    end  

  end

  def update
    @recipe_revision.update(recipe_revision_params)
    attachment = params[:photo]
    if !attachment.nil?
      photo_params = { "attachment" => attachment}
      @recipe_revision.photos.new(photo_params).save!
    end
  end

  def add_photo
    set_recipe_revision
    attachment = params[:recipe_photo]
    if !attachment.nil?
      photo_params = { "attachment" => attachment}
      @recipe_revision.photos.new(photo_params).save!
    end
  end

  def destroy
    @recipe_revision.destroy

  end

  def promote
    set_recipe_revision
    @recipe_revision.ready_to_test = true
    @recipe_revision.save!
    
    redirect_to controller: :users, action: :dashboard
  end

  private
    def set_recipe_revision
        @recipe_revision = RecipeRevision.find(params[:id])
    end

    def recipe_revision_params
      params.require(:recipe_revision).permit(:name, :recipe_id, :recipe_servings, :number_of_testers, :recipe_body, :notes_from_author, :version_number)
    end
end
