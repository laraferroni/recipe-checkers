class Project < ActiveRecord::Base

	belongs_to :user
	has_many :recipes


	def days_to_complete
		(self.test_deadline.to_date - Date.today).to_i
	end

	def all_tester_emails
		self.recipes.map{ |recipe| recipe.tester_recipes_with_email.collect{|tr| tr.user.email}[0]}.select{|x| x.present?}.uniq
	end

end


