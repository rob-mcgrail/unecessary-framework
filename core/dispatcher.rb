class Dispatcher
  # Interacts with rack, receiving the standard env object, passing off the path
  # to the router, receiving a response (from Renderer#render, via Controller#method, Router.connect)
  class << self

    def <<(env)
      if HardCache.get(env.path) != nil
        @response = {
          :body => HardCache.get(env.path),
          :code => '200'}

          # Fix above - you want to be able to return the whole @response, or be code aware.
          # Only did this because currently can't use Cache's #bitesize calls...
      else
        @response = Router.connect(env)
        # Cache check - can we put this in the HardCache
        unless SETTINGS[:development_mode]
          if @response[:cachable]
            HardCache.store env.path, @response[:body]
          end
        end
        # Sanity check - did we get back something invalid. No ducks...
        if @response.class != Hash
          @response = {:code => nil, :type => nil, :body => nil}
        end
      end
      # Standard rack response, with alternative emergency values.
      [@response[:code] || '501',
       @response[:type] || {"Content-Type" => "text/html"},
       @response[:body] || '<h1>Very serious problem</h1>']
    end
  end # class << self
end

