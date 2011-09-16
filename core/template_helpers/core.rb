module TemplateHelpers
  # Only expanding these as I need them...

  module Core

    def link_to(url, text, opts={})
      unless url =~ /\:\/\//
        url = "http://#{SETTINGS[:hostname]}#{url}"
      end
			attributes = ''
			opts.each do |k,v|
				attributes << k.to_s + '=\'' + v.to_s + '\' '
			end
      "<a href='#{url}' #{attributes}>#{text}</a>"
    end

    def image_tag(path, opts={})
      alt = opts[:alt] || ''
      cls = opts[:class] || ''
      unless path =~ /\:\/\//
        path = "http://#{SETTINGS[:hostname]}/images/#{path}"
      end
      "<img src='#{path}' alt='#{alt}' class='#{cls}'>"
    end

  end # module Includes
end

