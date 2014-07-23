source 'https://rubygems.org'

gem 'addressable', '2.3.5'      # pin to avoid RDF bug
gem 'dor-services', '~> 4.8'
gem 'lyber-core', '~> 3.2', '>=3.2.1'
gem 'net-ssh-krb', '~> 0.3.0'   # for Stanford SSH environment
gem 'robot-controller', '~> 0.3', '>= 0.3.6' # requires Resque
gem 'pry', '~> 0.10.0'          # for bin/console
gem 'slop', '~> 3.5.0'          # for bin/run_robot
gem 'rake', '~> 10.3.2'
gem 'rgeo', '~> 0.3.20'
gem 'rgeo-shapefile', '~> 0.2.3'

group :development do
  source 'http://sul-gems.stanford.edu'
  if File.exists?(mygems = File.join(ENV['HOME'],'.gemfile'))
    instance_eval(File.read(mygems))
  end
  gem 'rspec'
  gem 'awesome_print'
	gem 'debugger', :platform => :ruby_19
	gem 'yard'
	gem 'capistrano', '~> 3.2.1'
  gem 'capistrano-bundler', '~> 1.1'
  gem 'capistrano-rvm'
  gem 'lyberteam-capistrano-devel', '3.0.0.pre1'
  gem 'holepicker', '~> 0.3', '>= 0.3.3'
  gem 'capistrano-one_time_key'
end
