$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'ym_core/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'ym_core'
  s.version     = YmCore::VERSION
  s.authors     = ['Matt Atkins', 'Ian Mooney', 'Si Wilkins', 'Edward Andrews']
  s.email       = ['matt@yoomee.com', 'ian@yoomee.com', 'si@yoomee.com', 'edward@yoomee.com']
  s.homepage    = 'http://www.yoomee.com'
  s.summary     = 'Summary of YmCore.'
  s.description = 'Description of YmCore.'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.1.0'
  s.add_dependency 'rinku'
  s.add_dependency 'haml'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails'
  s.add_dependency 'sass-rails', '>= 3.2'
  s.add_dependency 'bootstrap-sass', '~> 3.0'
  s.add_dependency 'formtastic', '~> 2.3.0.rc3'
  s.add_dependency 'formtastic-bootstrap', '~> 3.0'

  #https://github.com/nickl-/formtastic-bootstrap3
  s.add_dependency 'dragonfly', '~> 0.9.10'
  s.add_dependency 'rack-cache'
  s.add_dependency 'rails_config', '~> 0.2.6'
  s.add_dependency 'will_paginate', '~> 3.0.3'
  s.add_dependency 'bootstrap-will_paginate', '~> 0.0.6'
  s.add_dependency 'html_truncator', '~> 0.2'
  s.add_dependency 'randumb'

  # for testing
  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'capybara', '~> 1.1.0'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'geminabox'
  s.add_development_dependency 'rb-fsevent', '~> 0.9.1'
  s.add_development_dependency 'ym_tools', '~> 0.1.13'
  s.add_development_dependency 'capybara-webkit'
  s.add_development_dependency 'listen', '~> 1.2.2'
  s.add_development_dependency 'database_cleaner', '1.2.0'

end
