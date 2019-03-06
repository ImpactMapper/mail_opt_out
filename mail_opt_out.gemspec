$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'mail_opt_out/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'mail_opt_out'
  spec.version     = MailOptOut::VERSION
  spec.authors     = ['Joel AZEMAR']
  spec.email       = ['joel.azemar@gmail.com']
  spec.homepage    = 'https://github.com/ImpactMapper/mail_opt_out'
  spec.summary     = 'Simple Opt In and Out Service'
  spec.description = 'MailOptOut let add OptIn and OptOut Users to lists'
  spec.license     = 'MIT'

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  spec.test_files = Dir['spec/**/*']

  spec.add_dependency 'rails', '~> 4.2.11'
  spec.add_dependency 'jsonapi.rb'

  spec.add_development_dependency 'sqlite3', '~> 1.3.6' # https://github.com/rails/rails/pull/35154
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'rubocop-rails_config'
  spec.add_development_dependency 'fabrication'
  spec.add_development_dependency 'ffaker'  
  spec.add_development_dependency 'with_model', '~> 2.0.0'
  
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'dotenv-rails'
  spec.add_development_dependency 'jsonapi-rspec'
  spec.add_development_dependency 'rails-dummy'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
