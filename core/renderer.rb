module Renderer
  # The rendering method, mixed in to AbstractController, called at the end of
  # controller methods ala: render 'blog/show', :layout => 'layouts/blog'
  #
  # Can also set the content type and http response code.
  #
  # #render always just assumes you are rendering the default application template (APP_TEMPLATE)
  # set in config/constants.rb. May add an option for this eventually.
  #
  # #render basically loads up a rack-ready response that is returned to the Dispatcher, via
  # the Router, usually.
  #
  # Rendering is performed by Haml::Engine (set default options in config/gem_settings), which takes
  # the template, 'self' as context (allowing it to use controller instance variables during render),
  # and blocks of further Haml::Engine action which execute inside template yield statements.
  #
  # Would be ideal to have some more caching in here (disk IO caching now done). For instance,
  # it seems extreme to be re-rendering the application template every time, booting up a new haml object...
  def render(template, opts={})
    defaults = {
      :code => '200',
      :type => 'text/html',
      :layout => nil,
      :cachable => nil,
    }

    @response = {}

    @response[:code]  =  opts[:code] || defaults[:code]
    @response[:type]  =  {"Content-Type" => opts[:type] || defaults[:type]}

    # We flag it as cachable in the router, and this is queried by the Dispatcher, which
    # is the optimal point at which to be storing and getting cached responses...
    @response[:cachable] =  opts[:cachable] || defaults[:cachable]

    layout = opts[:layout] || defaults[:layout]

    app_template = get_template(SETTINGS[:app_layout])

    # This conditional is not ideal. Couldn't get it to work in such a way that the 2nd block
    # arg can not happen without killing the last. May be some way with a proc or rendering
    # the templates un-nested...
    #
    # Think I could optimise this if I combined the raw strings with
    # some block accepting argument, somehow respecting template yields, and then
    # processed it all at once.
    if layout
      @response[:body] = Haml::Engine.new(app_template, HAML_OPTS).render(self) do
        Haml::Engine.new(get_template(layout), HAML_OPTS).render(self) do
          Haml::Engine.new(get_template(template), HAML_OPTS).render(self)
        end
      end
    else
      @response[:body] = Haml::Engine.new(app_template, HAML_OPTS).render(self) do
        Haml::Engine.new(get_template(template), HAML_OPTS).render(self)
      end
    end
    @response
  end

  # Renders partials within templates:
  # %section
  #     = partial 'blog/footer'
  def partial(file)
    template = get_template(file)
    Haml::Engine.new(template, HAML_OPTS).render(self)
  end


  private

  # Quick method to read the necessary template file.
  # Has some basic mem caching to avoid endless pointless disk IO
  #
  # Right now the cache is just a hash. It's also possibly a poor tradeoff - they both use
  # a fair bit of processors - need to profile properly. But the cached version seems to refuse
  # to respond or something strange occasionally...
  def get_template(template_name)
    if SETTINGS[:development_mode]
      File.read(PATH + SETTINGS[:view_folder] + template_name + '.haml')
    else
      if TemplateCache.get(template_name).nil?
        TemplateCache.store template_name, File.read(PATH + SETTINGS[:view_folder] + template_name + '.haml')
      end
      TemplateCache.get template_name
    end
  end

end

