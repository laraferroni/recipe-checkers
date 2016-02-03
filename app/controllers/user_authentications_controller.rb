class UserAuthenticationsController < ApplicationController
  before_action :set_user_authentication, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @user_authentications = UserAuthentication.all
    respond_with(@user_authentications)
  end

  def show
    respond_with(@user_authentication)
  end

  def new
    @user_authentication = UserAuthentication.new
    respond_with(@user_authentication)
  end

  def edit
  end

  def create
    @user_authentication = UserAuthentication.new(user_authentication_params)
    @user_authentication.save
    respond_with(@user_authentication)
  end

  def update
    @user_authentication.update(user_authentication_params)
    respond_with(@user_authentication)
  end

  def destroy
    @user_authentication.destroy
    respond_with(@user_authentication)
  end

  private
    def set_user_authentication
      @user_authentication = UserAuthentication.find(params[:id])
    end

    def user_authentication_params
      params[:user_authentication]
    end
end
