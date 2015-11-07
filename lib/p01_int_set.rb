class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, @store.length)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include? num
  end

  private

  def [](num)
    bucket = num % 20
    @store[bucket]
  end

  def num_buckets
    @store.length
  end


end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    @count += 1

    if @count == @store.length
      resize!
    end

    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    bucket = num % @store.length
    @store[bucket]
  end

  def num_buckets
    @store.length
  end

  def resize!

    new_store = Array.new(@store.length * 2) { Array.new }
    @store.each do |bucket|
      next if bucket.empty?
      bucket.each do |value|
        bucket = value % new_store.length
        new_store[bucket] << value
        remove(value)
      end
    end

    @store = new_store
  end
end
