class RecipesController < ApplicationController

	before_action :authenticate_user!
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  respond_to(:html, :js)

  def index
    @recipes = Recipe.all

  end

  def show
    if current_user.approved_for(@recipe.id)

    	@recipe_rating = @recipe.recipe_ratings.where("user_id = ?", current_user.id).first
    	if !@recipe_rating.present?
    		@recipe_rating = RecipeRating.new
    		@recipe_rating.user_id = current_user.id
    		@recipe_rating.recipe_revision_id = @recipe.recipe_revisions.last.id
    		@recipe_rating.save!
    	end
    else
      if current_user.pending_approval(@recipe.id)
        render action: :apply, id: @recipe.id       
      else  
        redirect_to action: :preview, id: @recipe.id
      end
    end
  end



  def preview
    set_recipe
    @author = @recipe.user
  end

  def apply
    set_recipe
    tr = TesterRecipe.new
    tr.recipe_id = @recipe.id
    tr.user_id = current_user.id
    tr.save
    UserMailer.new_tester_application(current_user, @recipe)
  end

  def approve
    set_recipe
    @tester =  User.find(params["tester"])
  end

  def approved
    set_recipe
    @tester =  User.find(params["tester"])
    logger.debug(@tester.name)
    tr = TesterRecipe.where("user_id = ? and recipe_id = ?", @tester.id, @recipe.id).first
    tr.approved = true
    tr.save!
    UserMailer.new_recipe_approved(@tester, @recipe)
    redirect_to controller: :users, action: :dashboard
  end

  def unsubscribe
    set_recipe
    logger.debug(current_user.id)
    logger.debug(@recipe.id)
    logger.debug(TesterRecipe.where("user_id = ? and recipe_id = ?", current_user.id, @recipe.id).count)
    tr = TesterRecipe.where("user_id = ? and recipe_id = ?", current_user.id, @recipe.id).first
    if tr.present?
      tr.destroy!
    end
    redirect_to controller: :users, action: :dashboard
  end



  def dashboard

  end

  def new
    @recipe = Recipe.new
    @recipe_revision = RecipeRevision.new
    if params["project_id"]
    	@project = Project.find(params["project_id"])
	    @recipe.project_id = @project.id
    end
  end

  def edit
    @project = @recipe.project
    if !@recipe.recipe_revisions.last.present?
      @recipe_revision = RecipeRevision.new
      @recipe_revision.recipe_id = @recipe.id
      @recipe_revision.version_number = 1
      @recipe_revision.save!
    else
      @recipe_revision = @recipe.recipe_revisions.last
      if @recipe_revision.ready_to_test
        last_version = @recipe_revision
        @recipe_revision = RecipeRevision.new
        @recipe_revision.recipe_id = @recipe.id
        @recipe_revision.version_number = last_version.version_number + 1
        @recipe_revision.recipe_body = last_version.recipe_body
        @recipe_revision.recipe_servings = last_version.recipe_servings
        @recipe_revision.notes_from_author = last_version.notes_from_author
        @recipe_revision.save!
        
      end
    end
  end

  def create
  	@recipe = Recipe.new(recipe_params)
		@recipe.save!
    @project = @recipe.project
    respond_to do |format|
      logger.debug(format)

      format.js
    end  

  end

  def update
    @recipe.update(recipe_params)
    @project = @recipe.project
    respond_to do |format|
      logger.debug(format)

      format.js
    end  
  end

  def destroy
    @recipe.destroy

  end



  private
    def set_recipe
        @recipe = Recipe.find(params[:id])
    end

    def recipe_params
      params.require(:recipe).permit(:name, :project_id, :user_id, :recipe_servings, :number_of_testers)
    end
end