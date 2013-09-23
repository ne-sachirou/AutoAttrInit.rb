# coding=utf-8
# license: Public Domain

unittest 'AutoAttrInit can set instance variables' do
  class CReq
    attr_accessor :a, :b, :c

    def initialize a, b, c
    end
    auto_attr_init :a, :c
  end

  c_req = CReq.new 4, 5, 6
  assert_equal 4, c_req.a
  assert_nil c_req.b
  assert_equal 6, c_req.c

  class CReq2
    attr_accessor :a, :b

    def initialize a, b, &p
    end
    auto_attr_init
  end

  c_req = CReq2.new(2, 3){|q| q }
  assert_equal 2, c_req.a
  assert_equal 3, c_req.b
end

unittest 'AutoAttrInit can worl for optional params' do
  class COpt
    attr_reader :a, :b

    def initialize a = 2, b = 3
    end
    auto_attr_init
  end

  c_opt = COpt.new 4
  assert_equal 4, c_opt.a
  assert_equal 3, c_opt.b

  c_opt = COpt.new
  assert_equal 2, c_opt.a
  assert_equal 3, c_opt.b
end

unittest 'AutoAttrInit can work for rest param' do
  class CRest
    attr_reader :r

    def initialize *r
    end
    auto_attr_init
  end

  c_rest = CRest.new 2, 3
  assert_equal [2, 3], c_rest.r

  c_rest = CRest.new
  assert_equal [], c_rest.r

  class CRest2
    attr_reader :a, :b, :r

    def initialize a, *r, b
    end
    auto_attr_init
  end

  c_rest = CRest2.new 2, 3, 4, 5
  assert_equal 2, c_rest.a
  assert_equal [3, 4], c_rest.r
  assert_equal 5, c_rest.b
end

unittest 'AutoAttrInit can work for hash param' do
  class CHash
    attr_reader :h

    def initialize h = {}
    end
    auto_attr_init
  end

  c_hash = CHash.new p1: 'p1', p2: 'p2'
  assert_equal({ p1: 'p1', p2: 'p2' }, c_hash.h)
end

unittest 'AutoAttrInit can work on keyword params' do
  class CKey
    attr_reader :p1, :p2

    def initialize *, p1: 'p1d', p2: 'p2d'
    end
    auto_attr_init
  end

  c_key = CKey.new p1: 'p1', p2: 'p2'
  assert_equal 'p1', c_key.p1
  assert_equal 'p2', c_key.p2

  c_key = CKey.new p2: 'p2'
  assert_equal 'p1d', c_key.p1
  assert_equal 'p2', c_key.p2

  class CKey2
    attr_reader :p1, :p2

    def initialize *, p1: 'p1d', p2: 'p2d', **opt
    end
    auto_attr_init

    def method_missing name, *args, &p
      @opt[name]
    end
  end

  c_key = CKey2.new p1: 'p1', p3: 'p3'
  assert_equal 'p1', c_key.p1
  assert_equal 'p2d', c_key.p2
  assert_equal 'p3', c_key.p3
end

unittest 'AutoAttrInit can work on keyword params with opt params' do
  class CKeyOpt
    attr_reader :a, :p1

    def initialize a = 3, p1: 'p1d'
    end
    auto_attr_init
  end

  c_keyopt = CKeyOpt.new
  assert_equal 3, c_keyopt.a
  assert_equal 'p1d', c_keyopt.p1
end
# vim:set et sw=2 sts=2 ff=unix foldmethod=marker:
