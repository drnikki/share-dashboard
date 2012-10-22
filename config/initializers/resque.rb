Dir[File.join(Rails.root, 'app', 'jobs', '*.rb')].each { |file| require file }


rails_root = Rails.root || File.dirname(__FILE__) + '/../..'
rails_env = Rails.env || 'development'

resque_config = YAML.load_file(rails_root.to_s + '/config/resque.yml')
Resque.redis = resque_config[rails_env]

# This isn't working on ubuntu.  stupid.
#config = YAML::load(File.open("#{Rails.root}/config/redis.yml"))[Rails.env]
#Resque.redis = Redis.new(:host => config['host'], :port => config['port'])
