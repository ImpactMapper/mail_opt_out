begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

ENV['DUMMY_APP_PATH']='spec/dummy'
# ENV['ENGINE']='mail_opt_out'
ENV['DISABLE_CREATE']='false'
ENV['DISABLE_MIGRATE']='false'
ENV['DATABASE_URL']='sqlite3::memory:'

require 'rails/dummy/tasks'

[
  'spec/dummy/app/assets/config/manifest.js',
  'spec/dummy/config/puma.rb',
  'spec/dummy/config/spring.rb',
].each do |file_name|
  `rm -vf #{file_name}`
end 

[
  'spec/dummy/app/assets/javascripts',
  'spec/dummy/app/assets/stylesheets',
].each do |dir_name|
  `rm -rvf #{dir_name}`
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

require 'rspec/core/rake_task'

desc 'Generate API request documentation from API specs'
RSpec::Core::RakeTask.new('docs:generate') do |t|
  t.pattern = 'spec/acceptance/**/*_spec.rb'
  t.rspec_opts = ["--format RspecApiDocumentation::ApiFormatter"]
end

task(default: :spec)
