class HomeController < ApplicationController
	before_action :authenticate_user!, only: [:unsubscibe]

  def index
  end

  def terms
  end

  def privacy
  end

  def unsubscribe
  end

  private
    def home_params
      params[:home]
    end
end
