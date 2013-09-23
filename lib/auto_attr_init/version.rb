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
module AutoAttrInit
  VERSION = "0.0.1"
end
