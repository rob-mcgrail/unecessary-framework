class AbstractCache
    class << self
      attr_reader :size
    end

    @h = {}
    @size = 0
    @max = 1000

  # Retrieve a template from the cache.
  def self.get(key)
    if @h[key].nil?
      nil
    else
      # add new read time
      @h[key][:time] = Time.new
      @h[key][:data]
    end
  end


  def self.store(key, data)
    @h[key] = {:data => data, :time => Time.new}
    # Increase the cache size count
    @size += data.bytesize
    # Check that we haven't exceeded the maximum
    if @size > @max
      lru_cleanup
    end
  end


  def self.clear
    @h = {}; @size = 0
  end

  private

  # Removes some hash items - the least recently used.
  # I tend to clear out about a third (see value x/3) when
  # the cache gets full...
  def self.lru_cleanup
    x = @h.length
    by_time = @h.sort do |a,b|
      a[1][:time].to_i <=> b[1][:time].to_i
    end
    by_time = by_time[0..(x/3)]
    by_time.each {|v| @h.delete(v[0])}
    recalculate_size
  end

  # Recalculates the size of the hash.
  def self.recalculate_size
    @size = 0
    @h.each {|k,v| @size += v[:data].bytesize}
  end
end

