<pre>LICENSE: Public Domain
AUTHOR: ne_Sachirou &lt;utakata.c4se@gmail.com&gt;
DATE: 2013-09-23</pre>

Install
=======

```sh
gem install auto_attr_init
```

From [RubyGems.org/auto_attr_init](https://rubygems.org/gems/auto_attr_init)

AutoAttrInit
============

Dart and CoffeeScript like "automatic field initialization" in Ruby.

Dart has automatic field initialization.

```dart
class Point {
  num x, y;
  Point(this.x, this.y);
}
```

CoffeeScript has a same function.

```coffeescript
class Point
  constructor: (@x, @y) ->
```

With this gem, you can do like this.

```ruby
class Point
  def initialize x, y; end
  attr_reader :x, :y
  auto_attr_init
end
```

Or like this.

```ruby
class Point
  def initialize ＠x, ＠y; end
  attr_reader :x, :y
end
```

_cf._ [Idiomatic Dart | Dart: Structured web apps](https://www.dartlang.org/articles/idiomatic-dart/#automatic-field-initialization) Dart's "automatic field initialization".

_cf._ [CoffeeScript Classes, Inheritance, and Super](http://jashkenas.github.io/coffee-script/#classes) CoffeeScript has same function.

_cf._ [Dart風のautomatic field initializationをRubyで - c4se記：さっちゃんですよ☆](http://c4se.hatenablog.com/entry/2013/09/23/075129) My blog entry.
