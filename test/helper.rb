# coding=utf-8

# Rubyで、D言語風にassertionを直書きする簡易unit test - c4se記：さっちゃんですよ☆
# http://c4se.hatenablog.com/entry/2013/08/15/022137
#
# @param test_name [String]
def unittest test_name, &proc
  if $DEBUG
    include Test::Unit::Assertions
    proc.call
    puts "#{test_name} ok."
  end
end
if $DEBUG
  require 'test/unit/assertions'
end
