module TemplateHelpers
  module Includes
    # Helpers for common HTML <head> content,
    # loads defaults for css and js

    def css(*args)
      #add options to remove defaults?
      if args[0] == 'defaults'
        args.delete 'defaults'
        %w(grids libraries space heading media content buttons).each {|a| args << a}
        args << 'code/' + SETTINGS[:coderay_css]
      end

      sheets = ''

      args.each do |sheet|
        sheets << "<link rel='stylesheet' href='http://#{SETTINGS[:hostname]}/stylesheets/#{sheet}.css'>\n"
      end
      sheets.chomp
    end


    def js(*args)
      if args[0] == 'defaults'
        args.insert(0, 'jquery-1.5.1.min')
        args.delete 'defaults'
      end

      scripts = ''

      args.each do |js|
        scripts << "<script src='http://#{SETTINGS[:hostname]}/javascript/#{js}.js'></script>\n"
      end
      scripts.chomp
    end


    def title(opts={})
      pagename = @title || 'somewhere'
      title = pagename + ' | ' + SETTINGS[:sitename]
    end


    def favicon(favicon = 'favicon.ico')
      "<link rel='shortcut icon' href='http://#{SETTINGS[:hostname]}/images/#{favicon}'>\n"
    end


    def ga_tracking
      "<script type='text/javascript'>
var _gaq = _gaq || [];
_gaq.push(['_setAccount', '#{SETTINGS[:ga_code]}']);
_gaq.push(['_trackPageview']);
(function() {
var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
</script>\n"
    end


  end # module Includes
end

