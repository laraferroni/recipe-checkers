class Project < ActiveRecord::Base

	belongs_to :user
	has_many :recipes


	def days_to_complete
		(self.test_deadline.to_date - Date.today).to_i
	end

	def all_tester_emails
		testers = self.recipes.select{ |r| r.tester_recipes.where("approved = ?", true).last.present? }
		#finish this
	end

end
