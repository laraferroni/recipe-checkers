class HomeController < ApplicationController


  def index
  end

  private
    def home_params
      params[:home]
    end
end
