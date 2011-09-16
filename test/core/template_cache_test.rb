require 'test/unit'

class TemplateCacheTest < Test::Unit::TestCase

  def teardown
    HardCache.clear
  end


  def test_store_and_get_string
    TemplateCache.store('some/file', '12345678910')

    assert_equal '12345678910', TemplateCache.get('some/file')
    assert_equal nil, TemplateCache.get('someother/file')
  end


  def test_cache_removes_least_recently_accessed_string
    TemplateCache.store('a', '1111111111')

    i = 0
    (SETTINGS[:template_cache_max]/10).times do
      i+=1
      TemplateCache.store(i.to_s, '22222222222')
    end

    assert_equal nil, TemplateCache.get('a')
    assert_equal '22222222222', TemplateCache.get(i.to_s)
  end


  def test_clear_clears_cache
    TemplateCache.store('some/file', '12345678910')
    TemplateCache.clear
    assert_equal nil, TemplateCache.get('some/file')
  end


  def test_clear_doesnt_destroy_cache
    TemplateCache.store('some/file', '12345678910')
    TemplateCache.clear
    TemplateCache.store('some/file', '12345678910')
    assert_equal '12345678910', TemplateCache.get('some/file')
  end


  def test_hash_calculation_is_accurate
    TemplateCache.clear
    TemplateCache.store('somefile','a')
    assert_equal 1, TemplateCache.size
  end

end

