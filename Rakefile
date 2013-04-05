require 'rake/clean'
require 'rake/testtask'
begin
  require 'watirmark'
rescue LoadError
  raise "You do not have watirmark, trying running a bundle install and make sure to run in the context of bundler"
end


PROB_DIR     = 'koans'

task :default => :test

task :test do
  cd PROB_DIR
  ruby 'path_to_enlightenment.rb'
end

