class RecipeRating < ActiveRecord::Base

	belongs_to :recipe_revision
	belongs_to :user
	has_many :photos, :as => :assetable



	def rating_photo
		if self.photos.present?
			return self.photos.last.attachment.url(:large)
		else
			return ""
		end
	end

end
