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

get '/users/reset_password' do
	erb :"/users/reset_password"
end

post '/users/reset_password/' do
	email_reset = params[:email_reset]
	user = User.first(:email => email_reset)
	user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
	user.password_token_timestamp = Time.now
	user.save
	send_email
	redirect to('/')
end

def send_email
  flash[:notice] = "Please check your email for your password reset link."
  # RestClient.post "https://api:key-b9d2ddeffe2814db3a84fd902e0db00a"\
  # "@api.mailgun.net/v2/sandbox45a4bf305d004c17971ce53c3c23b15d.mailgun.org/messages",
  # :from => "postmaster@sandbox45a4bf305d004c17971ce53c3c23b15d.mailgun.org",
  # :to => "jenny@rofls.info",
  # :subject => "Hello",
  # :text => "Testing some Mailgun awesomness!"
end

