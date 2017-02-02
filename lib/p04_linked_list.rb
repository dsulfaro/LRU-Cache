class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    self.prev.next = self.next if self.prev
    self.next.prev = self.prev if self.next
    self.next = nil
    self.prev = nil
    self
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
    @head == nil && @tail == nil
  end

  def get(key)
    ptr = @head
    while ptr != nil
      return ptr.val if ptr.key == key
      ptr = ptr.next
    end
    nil
  end

  def include?(key)
    ptr = @head
    qtr = @tail
    while ptr != qtr
      return true if ptr.key == key
      return true if qtr.key == key
      ptr = ptr.next
      qtr = qtr.prev
    end
    false
  end

  def append(key, val)
    new_link = Link.new(key, val)
    if @head == nil && @tail == nil
      @head = new_link
      @tail = new_link
    else
      @tail.next = new_link
      @tail.next.prev = @tail
      @tail = @tail.next
    end
  end

  def update(key, val)
    each do |l|
      puts l.to_s
      if l.key == key
        l.val = val
        return l
      end
    end
    nil
  end

  def remove(key)
    if @head != nil && @head.key == key
      @head = @head.next
      return
    end
    each do |l|
      if l.key == key
        l.remove
        return l.val
      end
    end
    nil
  end

  def each
    curr = @head
    until curr == nil
      yield curr
      curr = curr.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
