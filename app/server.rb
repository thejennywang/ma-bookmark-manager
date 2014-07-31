require 'data_mapper'
require 'sinatra'
require 'rack-flash'
require './lib/link'
require './lib/tag' 
require './lib/user'
require_relative 'data_mapper_setup'
require_relative 'helpers/application'
require_relative 'helpers/session'


class BookmarkManager < Sinatra::Base
	include AppHelpers
	include SessionHelpers

	enable :sessions
	set :sessions_secret, 'super secret'
	use Rack::Flash
	use Rack::MethodOverride

	get '/' do
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

	get '/users/new' do
		@user = User.new
		erb :"users/new"
	end

	post '/users' do
		@user = User.create(:email => params[:email],
								:password => params[:password],
								:password_confirmation => params[:password_confirmation])
		if @user.save
			session[:user_id] = @user.id
			redirect to('/')
		else
			flash.now[:errors] = @user.errors.full_messages
			erb :"users/new"
		end
	end

	get '/sessions/new' do
		erb :"sessions/new"
	end

	post '/sessions' do
		email, password = params[:email], params[:password]
		user = User.authenticate(email, password)
		if user
			session[:user_id] = user.id
			redirect to('/')
		else
			flash[:errors] = ["The email or password is incorrect"]
			erb :"sessions/new"
		end
	end

	delete '/sessions' do
		flash[:notice] = "Goodbye!"
		session[:user_id] = nil
		redirect to('/')
	end

	get '/users/reset_password/:token' do
		user = User.first(:email=> email)
		user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
		user.password_token_timestamp = Time.now
		user.save
		user = User.first(:password_token => token)
	end

	#start the server if ruby file executed directly
	run! if app_file ==$0

end