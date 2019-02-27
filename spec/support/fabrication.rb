require 'fabrication'
require 'ffaker'

Fabrication.configure do |config|
  config.fabricator_path = 'spec/fabricators'
  config.path_prefix = '.'
  config.sequence_start = 10000
  # config.generators << CustomGeneratorForORM
end

Dir[Dir.pwd + '/spec/fabricators/*.rb'].each { |fabricator_file| require(fabricator_file) }
