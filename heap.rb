class Heap
  attr_accessor :heap, :pos, :val

  # If the user supplies args so that @heap, @pos, @val have the following properties,
  # then the public instance methods in this class will preserve those proporties:
  #
  # @val is a hash, mapping elements of @heap to positive integers
  # @pos is a hash, mapping elements of @heap to their index in @heap
  # @heap is a (standard) array representation of a min heap, where ordering is determined by values in @val
  def initialize(heap, pos, val)
    @heap = heap
    @pos = pos
    @val = val
  end

  # i: heap index
  def parent(i)
    (i == 0) ? nil : ((i+1)/2) - 1
  end

  # i: heap index
  def child_l(i)
    (2*(i+1)-1 < @heap.length) ? 2*(i+1)-1 : nil
  end

  # i: heap index
  def child_r(i)
    (2*(i+1) < @heap.length) ? 2*(i+1) : nil
  end

  # a: element of @hash
  # val: positive integer less than @val[a]
  def val_upd(a, n)
    @val[a] = n
    bubble_up(@pos[a])
  end

  def extract_min
    min = @heap[0]
    last = @heap.pop
    @pos.delete(min) # not needed?
    return min if @heap.length == 0

    @heap[0] = last
    @pos[last] = 0
    bubble_down(0)

    min
  end

  # a: element of @hash
  # n: positive integer
  def ins(a, n)
    @val[a] = n
    i = @heap.length
    @heap[i] = a
    bubble_up(i)
  end

  private

  # i,j: heap indices
  def swap(i,j)
    v, w = @heap[i], @heap[j]
    @heap[i] = w
    @heap[j] = v
    @pos[v] = j
    @pos[w] = i
  end

  # i: heap index
  def bubble_up(i)
    return if i == 0

    j = parent(i)
    if @val[@heap[j]] > @val[@heap[i]]
      swap(i,j)
      bubble_up(j)
    end
  end

  # i: heap index
  def bubble_down(i)
    j, k = child_l(i), child_r(i)
    if (j && @val[@heap[j]] < @val[@heap[i]])
      min = (k && @val[@heap[k]] < @val[@heap[j]]) ? k : j
    elsif (k && @val[@heap[k]] < @val[@heap[i]])
      min = k
    else return
    end

    swap(i, min)
    bubble_down(min)
  end
end
