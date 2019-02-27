begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

desc('Documentation stats and measurements')
RDoc::Task.new('qa:docs') do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'MailOptOut'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

load 'rails/tasks/statistics.rake'

require 'bundler/gem_tasks'

require 'rubocop/rake_task'

desc('Codestyle check and linter')
RuboCop::RakeTask.new('qa:code') do |task|
  task.fail_on_error = true
  task.patterns = [
    'lib/**/*.rb',
    'app/**/*.rb',
    'spec/*.rb',
    'spec/support/*.rb',
    'spec/**/*_spec.rb'
  ]
end

desc('Run CI QA tasks')
task(qa: ['qa:docs', 'qa:code'])

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(spec: :qa) do |t|
  t.rspec_opts = "-I #{File.expand_path('../spec/', __FILE__)}"
  t.pattern =  File.expand_path('../spec/**/*_spec.rb', __FILE__)
end

task(default: :spec)
