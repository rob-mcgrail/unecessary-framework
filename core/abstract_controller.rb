class AbstractController
  require 'ostruct'
# Base controller class - all controllers inherit << AbstractController
#
# Controller files should all end with the suffix _controller.
#
# Includes the Renderer mixin because it's convenient to have rendering all
# take place within the scope of the controller.
  include Renderer

# Same deal with TemplateHelpers - add your own, or exotic ones, to each individual
# controller as needed. The base ones live here.
  include TemplateHelpers::Includes
  include TemplateHelpers::Core

# Controller class should declare routes:
#
#   R.add '/', 'Main#home', 'home'
#
# Although it is fine to declare routes all together in their own file ala rails.
# Router is available anywhere...
#
# Any vars that your templates and such require should be declared in your controller, as instance vars.
# You select your template with:
# render 'path/file'.
# Files should be .haml, but leave the extension off. Paths are relative to the views/ folder.
#
# Pages will always render inside the application template (in config/constants.rb), and an additional
# template can be passed to render via :layouts => 'path/layout'

#  def home
#    @title = 'home'
#    @patter = 'Welcome to <strong>robmcgrail.com</strong>'

#    render 'main/home', :layout => 'layouts/main'
#  end

  def initialize(p=nil, b=nil) # make this an empty class where method missing is a warning about no params?
    @p = p || OpenStruct.new({})
    @b = b || OpenStruct.new({})
  end


  def redirect_to(action, opts={})
    Router.instantiate_controller action, :body => opts
  end

end

