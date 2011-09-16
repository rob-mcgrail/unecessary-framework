require 'test/unit'
require File.dirname(__FILE__) + '/fixtures/testing_controller.rb'
require File.dirname(__FILE__) + '/fixtures/fake_rack_env.rb'

  R.add 'test', 'TestingController#basic', :name => 'basic'
  R.add 'testing/:cat/:year', 'TestingController#params_test', :name => 'params_test'

class RouterTest < Test::Unit::TestCase

  def test_takes_and_retrieves_static_url
    assert_equal 'abcd', R.connect(Env.new '/test')
  end

  def test_creates_static_url_url_helper
    assert_equal '/test', R.basic_url
  end

  def test_retrieves_static_url_with_trailing_slash
    assert_equal 'abcd', R.connect(Env.new '/test/')
  end

  def test_handles_slashes_in_static_urls
    R.add 'test/thing/another/many', 'TestingController#basic'
    assert_equal 'abcd', R.connect(Env.new '/test/thing/another/many')

    R.add 'test/thing/another', 'TestingController#basic'
    assert_equal 'abcd', R.connect(Env.new '/test/thing/another')

    R.add 'test/thing', 'TestingController#basic'
    assert_equal 'abcd', R.connect(Env.new '/test/thing')
  end

  def test_not_fussy_about_prefixed_slashes
    assert_equal 'abcd', R.connect(Env.new '/test')

    assert_equal 'abcd', R.connect(Env.new 'test')

    assert_equal '/test', R.basic_url

    R.add '/anothertest1', 'TestingController#basic'
    assert_equal 'abcd', R.connect(Env.new '/anothertest1')

    R.add '/anothertest2', 'TestingController#basic'
    assert_equal 'abcd', R.connect(Env.new 'anothertest2')

    R.add '/anothertest3', 'TestingController#basic', :name => 'basic'
    assert_equal '/anothertest3', R.basic_url
  end

  def test_handles_homepage_urls
    R.add '/', 'TestingController#home', :name => 'home'

    assert_equal 'home', R.connect(Env.new '/')
    assert_equal 'home', R.connect(Env.new '')
    assert_equal '/', R.home_url
  end

  def test_handles_special_characters_in_static_urls
    R.add '/a//b/', 'TestingController#basic'
    assert_equal 'abcd', R.connect(Env.new '/a//b/')

    R.add 'x+y', 'TestingController#basic', 'x'
    assert_equal 'abcd', R.connect(Env.new '/x+y')

    R.add 'x&y', 'TestingController#basic', 'x'
    assert_equal 'abcd', R.connect(Env.new '/x&y')

    R.add '--', 'TestingController#basic', 'x'
    assert_equal 'abcd', R.connect(Env.new '/--')

    R.add '__', 'TestingController#basic', 'x'
    assert_equal 'abcd', R.connect(Env.new '/__')

    R.add '??', 'TestingController#basic', 'x'
    assert_equal 'abcd', R.connect(Env.new '/??')

    R.add '**', 'TestingController#basic', 'x'
    assert_equal 'abcd', R.connect(Env.new '/**')
  end

  def test_understands_params
    assert_equal 'things and 2010', R.connect(Env.new '/testing/things/2010')
  end

  def test_not_fussy_about_prefixed_slashes_for_params
    assert_equal 'things and 2010', R.connect(Env.new '/testing/things/2010')

    assert_equal 'things and 2010', R.connect(Env.new 'testing/things/2010')
  end

  def test_retrieves_dynamic_url_with_trailing_slash
    assert_equal 'things and 2010', R.connect(Env.new '/testing/things/2010/')
  end

  def test_handles_static_slashes_in_dynamic_urls
    R.add 'test2/thing/another/many/:cat/:year', 'TestingController#params_test'
    assert_equal 'things and 2010', R.connect(Env.new '/test2/thing/another/many/things/2010')

    R.add 'test2/thing/another/:cat/:year', 'TestingController#params_test', 'params_test'
    assert_equal 'things and 2010', R.connect(Env.new '/test2/thing/another/things/2010')

    R.add 'test2/thing/:cat/:year', 'TestingController#params_test', 'params_test'
    assert_equal 'things and 2010', R.connect(Env.new '/test2/thing/things/2010')
  end


  def test_url_helpers_with_params
    assert_equal '/testing/things/2010', R.params_test_url(:cat => 'things', :year => 2010)
  end

  def test_handles_special_characters_in_dynamic_urls
    assert_equal 'a+b and a+b', R.connect(Env.new '/testing/a+b/a+b')
    assert_equal 'a&b and a&b', R.connect(Env.new '/testing/a&b/a&b')
    assert_equal 'a-b and a-b', R.connect(Env.new '/testing/a-b/a-b')
    assert_equal 'a_b and a_b', R.connect(Env.new '/testing/a_b/a_b')
    assert_equal 'a?b and a?b', R.connect(Env.new '/testing/a?b/a?b')
    assert_equal 'a*b and a*b', R.connect(Env.new '/testing/a*b/a*b')
  end

  # needed :
  # def test_ignore_case_for_request_type
  # def distinguishes between post and get
  # def can't post to get
  # def can't get via post
  # only get makes url helper
  # def post data makes its way through
end

