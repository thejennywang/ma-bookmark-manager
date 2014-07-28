require 'data_mapper'
require 'sinatra'

env = ENV["RACK_ENV"] || "development"
# we're telling datamapper to use a postgres database on localhost. The name will be 'bookmaker_manager_test' or 'bookmaker_manager_development" depending on the environment'
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require './lib/link' # this need to be done after datamapper is initialized

# After declaring your models, you shold finalize them
DataMapper.finalize

#However, the database tables don't exist yet. Let's tell datamapper to create them.
DataMapper.auto_upgrade!

class BookmarkManager < Sinatra::Base

	get '/' do
		# "Makers Academy"
		@links = Link.all
		erb :index
	end

	post '/links' do
		url = params["url"]
		title = params["title"]
		Link.create(:url => url, :title => title)
		redirect to('/')
	end

	#start the server if ruby file executed directly
	run! if app_file ==$0

end