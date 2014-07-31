module SessionHelpers

	def sign_up(email = "alice@example.com",
							password = "oranges!",
							password_confirmation = "oranges!")
	visit '/users/new'
	expect(page.status_code).to eq(200)
	fill_in :email, :with => email
	fill_in :password, :with => password
	fill_in :password_confirmation, :with => password_confirmation
	click_button "Sign up"
	end

	def sign_in(email, password)
		visit '/sessions/new'
		fill_in 'email', :with => email
		fill_in 'password', :with => password
		click_button 'Sign in'		
	end

	def send_simple_message(email)
  RestClient.post "https://api:key-b9d2ddeffe2814db3a84fd902e0db00a"\
  "@api.mailgun.net/v2/samples.mailgun.org/messages",
  :from => "Excited User <me@samples.mailgun.org>",
  :to => User.first.email,
  :subject => "Hello",
  :text => "Testing some Mailgun awesomness!"
end

end