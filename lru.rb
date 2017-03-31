class LRU

  def initialize(capacity, fetcher)
    @lookup = {}
    @cache = DoublyLinkedList.new
    @capacity = capacity
    @fetcher = fetcher
  end

  def put(key, data)
    node = @cache.add_node(key, data)
    if @cache.size > @capacity
      @cache.truncate
      @lookup.delete(key)
    end
    @lookup[key] = node
  end

  def get(key)
    if @lookup.key? key
      node = @lookup[key]
      @cache.to_front(node)

      node.data
    else
      data = @fetcher.call(key)
      put(key, data)

      data
    end
  end

end

class Node
  attr_accessor :key, :data, :next, :prev

  def initialize(key, data)
    @key = key
    @data = data
    @next = nil
    @prev = nil
  end
end


class DoublyLinkedList
  attr_accessor :head, :tail, :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def add_node(key, data)
    new_node = Node.new(key, data)

    if @head.nil?
      @tail = new_node
    else
      new_node.next = @head
    end

    @head = new_node
    @size += 1

    new_node
  end

  def to_front(node)
    return if @head.next.nil?

    node.prev.next = node.next if (node.prev && node.prev.next)
    node.next.prev = node.prev if (node.next && node.next.prev)

    @head.prev = node
    node.prev = nil
    node.next = @head.next
    @head = node
  end

  def truncate
    @tail.prev.next = nil
    @tail = @tail.prev

    @size -= 1
  end

end


def fetcher(key)
  puts "...fetching #{key}..."
  "value_of_#{key}"
end

@lru = LRU.new(3, method(:fetcher))


def puts_get(key)
  puts "requesting #{key}"
  puts "* #{@lru.get(key)}"
end

puts_get('a')
puts_get('b')
puts_get('b')
puts_get('a')
puts_get('c')
puts_get('a')
