class Error < AbstractController

# The Dispatcher expects there to be a method at Error#bug (500) when not in Development mode.
# The router expects there to be a method Error#not_found (404).

  R.add '/404', 'Error#not_found', :name => 'not_found'
  # Your 404 page. Generally called directly from within the router.
  def not_found
    @title = '404 - not found'
    @error = '<strong>404</strong> - That page doesn\'t exist. Be more careful in the future.'

    render 'errors/generic', :code => 404, :cachable => true
  end


  R.add '/bug', 'Error#bug', :name => 'bug'
  # The page you want displayed when an exception is raised. This will only display
  # when DEVELOPMENT_MODE is false
  def bug
    @title = 'E X C E P T I O N'
    @error = 'A <strong>serious</strong> error has occured...'

    render 'errors/generic', :code => 500, :cachable => true
  end
end

