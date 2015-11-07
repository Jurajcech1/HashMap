class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    if self.empty?
      return nil.hash
    end
    arr = []
    self.each_with_index do |el, i|
      arr << el.hash * i
    end
    arr.inject(:+)
  end
end

class String
  def hash
    letters = []
    self.split("").each_with_index do |el, i|
      letters << el.ord.hash * (i + 1)
    end
    letters.inject(:+)
  end
end

class Hash
  def hash
    key_value = []
    self.each do |k, v|
      key_value << k.to_s.hash + v.to_s.hash
    end
    key_value.inject(:+)
  end
end
