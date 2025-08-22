class HashMap
  attr_accessor :load_factor, :capacity, :buckets

  def initialize(load_factor, capacity)
    @load_factor = load_factor
    @capacity = capacity
    @buckets = Array.new(@capacity)
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end

  def set(key, value)
    index = hash(key) % @capacity
    if @buckets[index].nil?
      @buckets[index] = [] 
      @buckets[index] << [key, value] 
    else
      @buckets[index].each_with_index do |pair, position|  
        if pair.include?(key) 
          @buckets[index][position] = [key, value]
          return
        end
      end
      @buckets[index] << [key, value]
    end

    if current_load >= (@load_factor)
      resize
    end
  end
  
  def get(key)
    index = hash(key) % @capacity
    return nil if @buckets[index].nil?
    
    @buckets[index].each_with_index do |pair, position|
      if pair.include?(key) 
        return pair[1]
      end
    end
    nil
  end

  def has?(key)
    index = hash(key) % @capacity
    return false if @buckets[index].nil?

    @buckets[index].any? { |pair| pair[0] == key }
  end

  def remove(key)
    index = hash(key) % @capacity
    return nil if @buckets[index].nil?

    value = 0

    @buckets[index].each_with_index do |pair, position|
      if pair[0] == key
        value = pair[1]
        @buckets[index].delete_at(position)
        return value
      end
    end
    return nil
  end

  def length
    total = 0
    @buckets.each do |pairs|
      next if pairs.nil? 
      total += pairs.count
    end
    total
  end

  def clear
    @buckets = []
  end

  def keys
    keys = []
    return [] if @buckets.empty?

    @buckets.each do |bucket|
      next if bucket.nil?

      bucket.each do |pair|
        keys << pair[0]
      end 
    end
    keys
  end

  def values
    values = []
    return [] if @buckets.empty?

    @buckets.each do |bucket|
      next if bucket.nil?
      
      bucket.each do |pair|
        values << pair[1]
      end 
    end
    values
  end

  def entries
    kvp = []
    return [] if @buckets.empty?

    @buckets.each do |bucket|
      next if bucket.nil?
      
      bucket.each do |pair|
        kvp << pair
      end 
    end
    kvp
  end

  private

  def current_load
    length.to_f / @capacity
  end

  def resize
    new_capacity = @capacity * 2
    temp_buckets = Array.new(@capacity * 2)

    entries.each do |key, value|
      index = hash(key) % (@capacity * 2)
      if temp_buckets[index].nil?
        temp_buckets[index] = []
      end
        temp_buckets[index] << [key, value] 
    end
      @capacity = new_capacity
      @buckets = temp_buckets
  end
end