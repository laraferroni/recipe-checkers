class UserMailer <  Devise::Mailer


  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`

  layout 'email' # use email.(html|text).erb as the layout
  default from: '"Recipe Checkers" <admin@recipecheckers.com>'


  def tester_message(mail_to = "lara@laraferroni.com", subject="A message about the recipes you are testing")
    mail(to: mail_to, subject: '')
  end

  def initial_welcome_mail(@user)
  	mail(to: @user.email, subject: 'Welcome')
  end

  def new_tester_welcome(@user)
    mail(to: @user.email, subject: 'Welcome')
  end

  def new_author_welcome(@user)
    mail(to: @user.email, subject: 'Welcome')
  end

  def new_tester_application(@user, @recipe)
    mail(to: @user.email, subject: 'Welcome')
  end

  def new_recipe_approved(@user, @recipe)
    mail(to: @user.email, subject: 'Welcome')
  end

end