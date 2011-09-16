require 'test/unit'

class HardCacheTest < Test::Unit::TestCase

  def teardown
    HardCache.clear
  end


  def test_store_and_get_string
    HardCache.store('some/file', '12345678910')

    assert_equal '12345678910', HardCache.get('some/file')
    assert_equal nil, HardCache.get('someother/file')
  end


  def test_keys_ignores_trailing_slash
    HardCache.store('some/thing/', 'a')
    assert_equal 'a', HardCache.get('some/thing')
    assert_equal 'a', HardCache.get('some/thing/')

    HardCache.store('another/thing', 'a')
    assert_equal 'a', HardCache.get('another/thing')
    assert_equal 'a', HardCache.get('another/thing/')
  end


  def test_cache_removes_least_recently_accessed_string
    HardCache.store('a', '1111111111')

    i = 0
    (SETTINGS[:hard_cache_max]/10).times do
      i+=1
      HardCache.store(i.to_s, '22222222222')
    end

    assert_equal nil, HardCache.get('a')
    assert_equal '22222222222', HardCache.get(i.to_s)
  end


  def test_clear_clears_cache
    HardCache.store('some/file', '12345678910')
    HardCache.clear
    assert_equal nil, HardCache.get('some/file')
  end


  def test_clear_doesnt_destroy_cache
    HardCache.store('some/file', '12345678910')
    HardCache.clear
    HardCache.store('some/file', '12345678910')
    assert_equal '12345678910', HardCache.get('some/file')
  end


  def test_hash_calculation_is_accurate
    HardCache.clear
    HardCache.store('somefile','a')
    assert_equal 1, HardCache.size
  end

end

