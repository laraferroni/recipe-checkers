# http://rails-bestpractices.com/posts/45-use-sti-and-polymorphic-model-for-multiple-uploads
class Asset < ActiveRecord::Base

  # Associations
  belongs_to :assetable, polymorphic: true

  # Paperclip configured in inherited models

end
