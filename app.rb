# Connect to database.
DataMapper.setup(:default, SETTINGS[:db])

# Load application controllers.
Dir['controllers/*_controller.rb'].each {|file| require file }

# Load application models.
Dir['models/*.rb'].each {|file| require file }

# Finalize models.
DataMapper.finalize

