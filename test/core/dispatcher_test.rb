#require 'test/unit'
#require 'ostruct'

#class DispatcherTest < Test::Unit::TestCase

#  def test_bad_dispatcher_path_returns_rack_response
#    env = OpenStruct.new({:path => 'things'})
#    assert_equal ["501", {"Content-Type"=>"text/html"}, "<h1>Very serious problem</h1>"], Dispatcher<<(env)
#  end

#end

