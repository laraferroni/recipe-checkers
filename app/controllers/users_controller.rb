class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :dashboard]

  before_action :authenticate_user!

  respond_to :html

  def index
    @users = User.all
    respond_with(@users)
  end

  def start

  end

  def dashboard
    if current_user.tester || current_user.author
      @project = current_user.projects
      @all_available_recipes = Recipe.recipes_available
    else
      redirect_to controller: :registrations, action: :edit
    end
  end

  def show
    respond_with(@user)
  end



  def new
    @user = User.new
    respond_with(@user)
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.save

    respond_with(@user)
  end

  def update
    @user.update(user_params)
    respond_with(@user)
  end

  def destroy
    @user.destroy
    respond_with(@user)
  end

  def whitelist
    tester = User.find(params["tester"])
    autoapprove = AuthorWhitelist.new
    autoapprove.user_id = current_user.id
    autoapprove.tester_id = tester.id
    autoapprove.save!

    redirect_to action: :dashboard
  end

  def blacklist
    tester = User.find(params["tester"])
    autodeny = AuthorBlacklist.new
    autodeny.user_id = current_user.id
    autodeny.tester_id = tester.id
    autodeny.save!
    
    redirect_to action: :dashboard
  end




  private
    def set_user
      if current_user.present?
        @user = current_user
      else
        @user = User.find(params[:id])
      end
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :author, :tester, :email)
    end
end
