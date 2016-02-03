# http://rails-bestpractices.com/posts/45-use-sti-and-polymorphic-model-for-multiple-uploads
class Photo < Asset
  
   include Rails.application.routes.url_helpers

  # Paperclip Configuration
  has_attached_file :attachment,
    styles: {
      thumb: "75x75#",    # 75px max
      square: "150x150#", # 150 min (will crop to 150 x 150)
      medium: "500x500>",  # 500 max
      large:  "1000x1000>" #1000 max
    },
    default_url:"/:style/missing.png",
    # allow the public to download photos
    s3_permissions: :public_read,
    # use "https://bucket-name.s3.amazonaws.com" style urls
    # instead of "https://s3.amazonaws.com/bucket-name"
    url: ':s3_domain_url',
    # path is required in order to use :s3_domain_url
    path: '/:class/attachments/:id_partition/:style/:basename.:extension:fingerprint'
    
  before_save :extract_dimensions
  serialize :orientation


  validates_attachment :attachment,
    presence: true,
    content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }




  def to_jq_upload
    {
      "name" => read_attribute(:attachment_file_name),
      "size" => read_attribute(:attachment_file_size),
      "url" => attachment.url(:original),
      "thumbnail_url" => attachment.url(:thumb),
      "delete_url" => photo_path(self),
      "delete_type" => "DELETE" 
    }
  end

  def is_landscape
      if self.orientation.nil?
        save_image_dimensions
      else
      return self.orientation[0] >= self.orientation[1]
      end
  end
    

  def save_image_dimensions
    geo = Paperclip::Geometry.from_file(self.attachment.url(:original))
    self.orientation = [geo.width.to_i, geo.height.to_i]
    self.save
  end

  protected
  
  private
  # Retrieves dimensions for image assets
  # @note Do this after resize operations to account for auto-orientation.
  def extract_dimensions
    tempfile = attachment.queued_for_write[:original]
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      self.orientation = [geometry.width.to_i, geometry.height.to_i]
    end
  end

end
