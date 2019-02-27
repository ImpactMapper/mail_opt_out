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

  spec.add_dependency 'rails', '~> 5.2.2'

  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'rspec-rails'

end
