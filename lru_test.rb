require 'minitest/autorun'
require_relative './lru'

class TestDoublyLinkedList < MiniTest::Unit::TestCase

  def setup
    @dll = DoublyLinkedList.new
  end

  def test_size
    @dll.add_node(:a,1)
    @dll.add_node(:b,2)
    @dll.add_node(:c,2)

    assert_equal 3, @dll.size
  end

  def test_add_node_to_empty
    assert_equal @dll.size, 0
    @dll.add_node(:a, 1)
    assert_equal @dll.size, 1
    assert_equal @dll.head.key, :a
    assert_equal @dll.tail.key, :a
  end

  def test_add_node_to_non_empty
    @dll.add_node(:a,1)
    @dll.add_node(:b,2)
    @dll.add_node(:c,2)

    assert_equal @dll.head.key, :c
    assert_equal @dll.tail.key, :a
  end

  def test_truncate
    @dll.add_node(:a,1)
    @dll.add_node(:b,2)
    @dll.add_node(:c,2)
    @dll.truncate

    assert_equal @dll.size, 2
    assert_equal @dll.head.key, :c
    assert_equal @dll.tail.key, :b
  end

  def test_to_front

  end

end

class TestLRU < MiniTest::Unit::TestCase

  def setup
    @lru = LRU.new(3, method(:fetcher))
  end

  def fetcher(key)
    "value_of_#{key}"
  end

  def test_put_small_cache

  end

  def test_put_large_cache

  end

end
