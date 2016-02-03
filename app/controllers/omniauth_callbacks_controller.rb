class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    if current_user.present?
      logger.debug("update_omniauth")
      auth = current_user.update_omniauth(request.env["omniauth.auth"])
      if auth.persisted?
        flash.notice = "Authentication added!"
      elsif auth.exists_for_another_user?
        flash.notice = "Your credentials for this social network are associated with another user account. Contact support if you wish to merge these accounts."
      else
        flash.notice = "Authentication could not be added. #{auth.errors.full_messages.join(", ")}"
      end
      redirect_to edit_user_registration_path
      return
    end

    user = User.from_omniauth(request.env["omniauth.auth"])
    user.set_icon(request.env["omniauth.auth"])
  
    if user.persisted?
      #flash.notice = "Signed in!"
      user.remember_me = true
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      auth_attributes = request.env["omniauth.auth"].slice(:provider, :uid, :info, :credentials)
      session["omniauth.auth_attributes"] = auth_attributes
      session["omniauth.params"] = request.env["omniauth.params"] if request.env["omniauth.params"].present?
      @resource = user
      @password = Devise.friendly_token[0,20]
      @welcome_page = true
      render 'devise/registrations/new'

    end
  end


  alias_method :facebook, :all
  alias_method :google_oauth2, :all
  alias_method :twitter, :all


  protected

  def has_existing_account_and_signing_up?
    session["omniauth.auth_attributes"].present? &&
      @resource.errors[:email].include?("has already been taken")
  end
  helper_method :has_existing_account_and_signing_up?


end
