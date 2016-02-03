class RecipeNotesController < ApplicationController
  before_action :set_recipe_note, only: [:show, :edit, :update, :remove, :destroy, :dashboard]

  before_action :authenticate_user!


def index
    @recipe_notes = RecipeNote.all

  end

  def show

  end

  def dashboard

  end

  def new
    @recipe_note = RecipeNote.new

  end

  def edit
  end

  def create
  	@recipe_note = RecipeNote.new(recipe_note_params)
		@recipe_note.save

    respond_to do |format|
      format.js
    end    

  end

  def update
    @recipe_note.update(recipe_note_params)

  end

  def remove
  	@recipe_note.hide = true
  	@recipe_note.save!
  	render :text => "", status:200
  end

  def destroy
    @recipe_note.destroy

  end

  private
    def set_recipe_note
        @recipe_note = RecipeNote.find(params[:id])
    end

    def recipe_note_params
      params.require(:recipe_note).permit(:notes, :recipe_revision_id, :line_id, :user_id)
    end
end