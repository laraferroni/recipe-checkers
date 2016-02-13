class RegistrationsController < Devise::RegistrationsController


	def create

	  super

	  #set our 
		if session[:temp_user_prefs].present?
			up = UserPreference.find(session[:temp_user_prefs].to_i)
			up.user_id = resource.id
			up.save!
		end

	end

	def edit
		if current_user.present?
			@user_prefs = current_user.user_preference
		else
			if session[:temp_user_prefs].present?
				@user_prefs = UserPreference.find(session["temp_user_prefs"].to_i)
			else
				@user_prefs = UserPreference.new
			end
		end
	end

	def update
		configure_permitted_parameters
		super
		resource.save!
	end

  protected

    def after_update_path_for(resource)
      user_path(resource)
    end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update).push(:first_name, :last_name, :author, :tester, :email, :tester_bio, :author_bio, :website)
  end

end