# A fake rack request
require 'rack'
class Env < Rack::Request
  attr_accessor :path

  def initialize(path, type = 'get')
    @path = path
    self.instance_variable_set(('@' + type).to_sym, true)
  end

  def POST()
    {}
  end

  def get?
    @get
  end

  def post?
    @post
  end
end

