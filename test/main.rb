# coding=utf-8

require 'bundler'
Bundler.require
require 'test/unit'
require "#{__dir__}/helper.rb"
require "#{__dir__}/../lib/auto_attr_init.rb"
require "#{__dir__}/auto_attr_init/refinments_test.rb"
require "#{__dir__}/auto_attr_init/auto_ai_test.rb"
