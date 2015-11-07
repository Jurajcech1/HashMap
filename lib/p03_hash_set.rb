require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    @count += 1

    if @count == @store.length
      resize!
    end
    self[key] << key
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    self[key].delete(key)
  end

  private

  def [](num)
    bucket = num.hash % num_buckets
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
