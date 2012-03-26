$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ym_core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ym_core"
  s.version     = YmCore::VERSION
  s.authors     = ["Matt Atkins", "Ian Mooney", "Si Wilkins"]
  s.email       = ["matt@yoomee.com", "ian@yoomee.com", "si@yoomee.com"]
  s.homepage    = "http://www.yoomee.com"
  s.summary     = "TODO: Summary of YmCore."
  s.description = "TODO: Description of YmCore."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.0"
  s.add_dependency "dragonfly", "~> 0.9.10"
  s.add_dependency "rails_config", "~> 0.2.6"
  
end
