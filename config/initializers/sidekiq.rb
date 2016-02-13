Sidekiq.configure_server do |config|
  config.redis = {
    url: ENV['REDIS_URL'],
    namespace: "recipecheckers-#{Rails.env}"
  }
  config.error_handlers << ->(ex, context) {  Honeybadger.notify_or_ignore(ex, parameters: context)}
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: ENV['REDIS_URL'],
    namespace: "recipecheckers-#{Rails.env}"
  }
end
