class Link
  attr_accessor :key, :val, :next

  def initialize(key = nil, val = nil, nxt = nil)
    @key, @val, @next = key, val, nxt
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    each { |link| return link if link.next == nil}
  end

  def empty?
    @head.nil?
  end

  def get(key)
    each { |link| return link.val if link.key == key }
  end

  def include?(key)
    each { |link| return true if link.key == key }
    false
  end

  def insert(key, val)
    @head = Link.new(key, val, @head)
  end

  def remove(key)
    if @head.key == key
      @head = @head.next
      return
    end

    count = 0
    link_to_remove = nil
    each do |link|
      count += 1
      if link.key == key
        link_to_remove = link
        break
      end
    end
    next_value = link_to_remove.next
    self[count - 1].next = next_value
  end

  def each(&prc)
    current_link = @head
    until current_link == nil
      prc.call(current_link)
      current_link = current_link.next
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
