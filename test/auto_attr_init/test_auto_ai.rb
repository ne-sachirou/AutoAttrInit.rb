# coding=utf-8

class TestAutoAttrInit < Test::Unit::TestCase
  def test_AutoAttrInit_can_set_instance_variables
    creq = Class.new do
      attr_reader :a, :b, :c
      def initialize a, b, c
      end
      auto_attr_init :a, :c
    end
    c_req = creq.new 4, 5, 6
    assert_equal 4, c_req.a
    assert_nil c_req.b
    assert_equal 6, c_req.c

    creq = Class.new do
      attr_reader :a, :b
      def initialize a, b, &p
      end
      auto_attr_init
    end
    c_req = creq.new(2, 3){|q| q }
    assert_equal 2, c_req.a
    assert_equal 3, c_req.b
  end

  def test_AutoAttrInit_can_work_for_optional_params
    copt = Class.new do
      attr_reader :a, :b
      def initialize a = 2, b = 3
      end
      auto_attr_init
    end
    c_opt = copt.new 4
    assert_equal 4, c_opt.a
    assert_equal 3, c_opt.b
    c_opt = copt.new
    assert_equal 2, c_opt.a
    assert_equal 3, c_opt.b
  end

  def test_AutoAttrInit_can_work_for_rest_param
    crest = Class.new do
      attr_reader :r
      def initialize *r
      end
      auto_attr_init
    end
    c_rest = crest.new 2, 3
    assert_equal [2, 3], c_rest.r
    c_rest = crest.new
    assert_equal [], c_rest.r

    crest = Class.new do
      attr_reader :a, :b, :r
      def initialize a, *r, b
      end
      auto_attr_init
    end
    c_rest = crest.new 2, 3, 4, 5
    assert_equal 2, c_rest.a
    assert_equal [3, 4], c_rest.r
    assert_equal 5, c_rest.b
  end

  def test_AutoAttrInit_can_work_for_hash_param
    chash = Class.new do
      attr_reader :h
      def initialize h = {}
      end
      auto_attr_init
    end
    c_hash = chash.new p1: 'p1', p2: 'p2'
    assert_equal({ p1: 'p1', p2: 'p2' }, c_hash.h)
  end

  def test_AutoAttrInit_can_work_on_keyword_params
    ckey = Class.new do
      attr_reader :p1, :p2
      def initialize *, p1: 'p1d', p2: 'p2d'
      end
      auto_attr_init
    end
    c_key = ckey.new p1: 'p1', p2: 'p2'
    assert_equal 'p1', c_key.p1
    assert_equal 'p2', c_key.p2
    c_key = ckey.new p2: 'p2'
    assert_equal 'p1d', c_key.p1
    assert_equal 'p2', c_key.p2

    ckey = Class.new do
      attr_reader :p1, :p2
      def initialize *, p1: 'p1d', p2: 'p2d', **opt
      end
      auto_attr_init
      def method_missing name, *args, &p
        @opt[name]
      end
    end
    c_key = ckey.new p1: 'p1', p3: 'p3'
    assert_equal 'p1', c_key.p1
    assert_equal 'p2d', c_key.p2
    assert_equal 'p3', c_key.p3
  end

  def test_AutoAttrInit_can_work_on_keyword_params_with_opt_params
    ckeyopt = Class.new do
      attr_reader :a, :p1
      def initialize a = 3, p1: 'p1d'
      end
      auto_attr_init
    end

    c_keyopt = ckeyopt.new
    assert_equal 3, c_keyopt.a
    assert_equal 'p1d', c_keyopt.p1
  end
end
