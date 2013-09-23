# coding=utf-8
# license: Public Domain

using AutoAttrInit::Refinments
unittest 'Array#find_deep' do
  assert_equal 4, [2, 3, [4]].find_deep{|e| e == 4 }
  assert_nil [2, 3, [4]].find_deep{|e| e == 5 }
end
