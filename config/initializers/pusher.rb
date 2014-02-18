if File.exists?(File.expand_path('../../pusher.yml', __FILE__))
  config = HashWithIndifferentAccess.new(YAML.load_file(File.expand_path('../../pusher.yml', __FILE__)))
  Pusher.app_id = config[Rails.env][:app_id]
  Pusher.key = config[Rails.env][:key]
  Pusher.secret = config[Rails.env][:secret]
end