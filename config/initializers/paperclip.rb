Paperclip::Attachment.default_options[:storage] = :s3
Paperclip::Attachment.default_options[:s3_credentials] = {
  bucket:            ENV['AWS_S3_ASSETS_BUCKET'],
  access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
}
Paperclip::Attachment.default_options[:s3_protocol] = 'https'

