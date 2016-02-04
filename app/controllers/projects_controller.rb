class ProjectsController < ApplicationController

	before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  respond_to(:html, :js)

  def index
    @projects = Project.all

  end

  def show

  end

  def dashboard

  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
  	@project = Project.new(project_params)
		@project.save!
    respond_to do |format|
      logger.debug(format)

      format.js
    end  

    redirect_to controller: :users, action: :dashboard

  end

  def update
    @project.update(project_params)

  end

  def destroy
    @project.destroy

  end

  private
    def set_project
        @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :test_deadline, :terms, :user_id)
    end
end
