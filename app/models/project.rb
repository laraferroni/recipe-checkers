class Project < ActiveRecord::Base

	belongs_to :user
	has_many :recipes


	def days_to_complete
		(self.test_deadline.to_date - Date.today).to_i
	end
end
