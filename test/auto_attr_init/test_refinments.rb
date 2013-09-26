# coding=utf-8

using AutoAttrInit::Refinments

class TestArray < Test::Unit::TestCase
  def test_find_deep
    assert_equal 4, [2, 3, [4]].find_deep{|e| e == 4 }
    assert_nil [2, 3, [4]].find_deep{|e| e == 5 }
  end
end
