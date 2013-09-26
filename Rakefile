# coding=utf-8

require 'bundler/gem_tasks'

desc 'Run tests and show the results.'
task :test do
  require './lib/auto_attr_init.rb'
  require 'test/unit'
  require './test/helper.rb'
  Test::Unit::AutoRunner.run true, 'test'
end

task :default
