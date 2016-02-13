class ProjectsController < ApplicationController

	before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :author_only, only: [:edit, :update, :destroy]

  respond_to(:html, :js)

  def index
    @projects = Project.all

  end

  def show

  end

  def dashboard

  end

  def author_only
    set_project
    if @project.user != current_user
      render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
    end
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

  #sends a message to testers of the project
  def tester_message
    set_project
    UserMailer.delay.tester_message(@project, params["message"])
    render :text => "Mailing testers", :content_type => 'text/html', status:200
  end

  private
    def set_project
        @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :test_deadline, :terms, :user_id)
    end
end
