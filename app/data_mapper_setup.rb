env = ENV["RACK_ENV"] || "development"
# DataMapper::Logger.new(STDOUT, :debug)
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
# After declaring your models, you should finalize them
DataMapper.finalize
#However, the database tables don't exist yet. Let's tell datamapper to create them.
DataMapper.auto_migrate!