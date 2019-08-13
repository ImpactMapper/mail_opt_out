source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Declare your gem's dependencies in mail_opt_out.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

group :test do 
  gem 'gibbon'
  gem 'rspec_junit_formatter'
  gem 'rspec_api_documentation', github: 'zipmark/rspec_api_documentation'
end 