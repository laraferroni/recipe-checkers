module ApplicationHelper

	def oauth_and_return_path(provider)
    user_omniauth_authorize_path(provider, return_to: request.path)
  end

  def nice_date(date)
    if !date.nil?
      l date, format: :friendly_no_year 
      #date.strftime("%_m/%d/%Y").strip
    end
  end

  def nice_time(time)
    if !time.nil?
      time.strftime("%l:%M %p").strip
    end

  end


end
