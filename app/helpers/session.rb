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

	def send_email(user)
		RestClient.post "https://api:key-b9d2ddeffe2814db3a84fd902e0db00a"\
  "@api.mailgun.net/v2/sandbox45a4bf305d004c17971ce53c3c23b15d.mailgun.org/messages",
  :from => "postmaster@sandbox45a4bf305d004c17971ce53c3c23b15d.mailgun.org",
  :to => "#{user.email}",
  :subject => "Password Reset",
  :text => "To reset your password, please visit http://localhost:9292/reset/#{user.password_token}"
end

end