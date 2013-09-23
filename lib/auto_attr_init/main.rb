# coding=utf-8
# license: Public Domain

# Dart like automatic field initialization.
# https://www.dartlang.org/articles/idiomatic-dart/#automatic-field-initialization
#
# ```dart
# class Point {
#   num x, y;
#   Point(this.x, this.y);
# }
# ```
#
# ```ruby
# class Point
#   def initialize x, y
#   end
#
#   attr_reader :x, :y
#   auto_attr_init
# end
# ```
require 'ripper'
require 'sorcerer'
require 'aspectr'
require "#{__dir__}/refinments.rb"
require "#{__dir__}/detect_params.rb"
require "#{__dir__}/assign_params.rb"
require "#{__dir__}/auto_ai_aspect.rb"
require "#{__dir__}/auto_ai.rb"
