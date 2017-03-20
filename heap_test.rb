require 'minitest/autorun'
require_relative './heap'

class TestHeap < MiniTest::Unit::TestCase

  def setup
    @heap = [:a, :b, :c, :d, :e, :f, :g, :h, :i]
    @val = {a:2, b:4, c:8, d:9, e:4, f:12, g:9, h:11, i:13}
    @pos = {a:0, b:1, c:2, d:3, e:4, f:5, g:6, h:7, i:8}

    @heap2 = [:a]
    @val2 = {a:0}
    @pos2 = {a:0}

    @h = Heap.new(@heap, @pos, @val)
    @h2 = Heap.new(@heap2, @pos2, @val2)
  end

  def test_extract_min
    assert_equal @h.extract_min, :a
    assert_equal @h.heap, [:b, :e, :c, :d, :i, :f, :g, :h]
    assert_equal @h.pos, {b:0, c:2, d:3, e:1, f:5, g:6, h:7,i:4}
    assert_equal @val, {a:2, b:4, c:8, d:9, e:4, f:12, g:9, h:11, i:13}
  end

  def test_extract_min_sigleton
    assert_equal @h2.extract_min, :a
    assert_equal @val2, {a: 0}
    assert_equal @pos2, {}
    assert_equal @heap2, []
  end

  def test_parent
    assert_nil @h.parent(0)
    assert_equal @h.parent(1), 0
    assert_equal @h.parent(4), 1
    assert_equal @h.parent(5), 2
  end

  def test_swap
    @h.send('swap', 1, 2) # send used as swap is a private method
    assert_equal @heap, [:a, :c, :b, :d, :e, :f, :g, :h, :i]
    assert_equal @val, {a:2, b:4, c:8, d:9, e:4, f:12, g:9, h:11, i:13}
    assert_equal @pos, {a:0, b:2, c:1, d:3, e:4, f:5, g:6, h:7, i:8}
  end

end
