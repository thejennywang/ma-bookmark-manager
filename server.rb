require 'data_mapper'
require 'sinatra'

env = ENV["RACK_ENV"] || "development"
# DataMapper::Logger.new(STDOUT, :debug)
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require './lib/link' # this need to be done after datamapper is initialized
require './lib/tag' # this need to be done after datamapper is initialized

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
		tags = params["tags"].split(" ").map do |tag|
			# this will either find this tag or create
			# it if it doesn't exist already
			Tag.first_or_create(:text => tag)
		end
		Link.create(:url => url, :title => title, :tags => tags)
		redirect to('/')
	end

	get '/tags/:text' do
		tag = Tag.first(:text => params[:text])
		@links = tag ? tag.links : []
		erb :index
	end

	#start the server if ruby file executed directly
	run! if app_file ==$0

end