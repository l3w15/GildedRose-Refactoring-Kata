require 'simplecov'
require 'simplecov-console'

puts "spec helper running"

SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.start
