class HardCache < AbstractCache
    @h = {}
    @size = 0
    @max = SETTINGS[:hard_cache_max]

  def self.store(key, data)
    if key.length > 1
      key.slice!(-1) if key[-1,1] == '/'
    end

    super
  end

  def self.get(key)
    if key.length > 1
      key.slice!(-1) if key[-1,1] == '/'
    end

    super
  end

end

