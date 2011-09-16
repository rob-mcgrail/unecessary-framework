require 'rubygems'

# gem dependencies
require 'RedCloth'
require 'haml'
require 'coderay'
require 'haml-coderay'
require 'data_mapper'

PATH = File.expand_path(File.dirname(__FILE__))

SETTINGS = {}

$:.unshift PATH

require 'config/constants'
require 'config/gem_settings'

require 'core/template_helpers/includes'
require 'core/template_helpers/core'

require 'core/caches/abstract_cache'
require 'core/caches/template_cache'
require 'core/caches/hard_cache'

require 'core/renderer'
require 'core/router'
require 'core/dispatcher'
require 'core/abstract_controller'
require 'core/abstract_model'

