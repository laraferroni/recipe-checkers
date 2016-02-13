class UserMailer <  Devise::Mailer


  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`

  layout 'email' # use email.(html|text).erb as the layout
  default from: '"Recipe Checkers" <admin@recipecheckers.com>'


  def tester_message(project, message = "hi. just checking in. how's it going with the testing?")
  	@message_from_author = message
    @project = project
    @root_url = root_url
    logger.debug(@project.all_tester_emails.join(","))
    mail(bcc: @project.all_tester_emails.join(","), subject: "RecipeCheckers message from #{@project.user.name}")
  end

  def initial_welcome_mail(user)
  	@user = user
    @root_url = root_url
  	mail(to: @user.email, subject: 'Welcome to RecipeCheckers')
  end

  def new_tester_welcome(user)
  	@user = user
  	@root_url = root_url
    mail(to: @user.email, subject: 'How to Test with RecipeCheckers')
  end

  def new_author_welcome(user)
  	@user = user  	
  	@root_url = root_url  	
    mail(to: @user.email, subject: 'How to Get Your Recipes Tested with RecipeCheckers')
  end

  def new_tester_application(user, recipe)
  	@tester = user
  	@recipe = recipe
    @user = @recipe.user
    @root_url = root_url
    mail(to: @user.email, subject: 'Welcome')
  end

  def new_recipe_approved(user, recipe)
  	@user = user
  	@recipe = recipe
    @root_url = root_url
    mail(to: @user.email, subject: 'Welcome')
  end

end