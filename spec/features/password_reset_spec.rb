feature "User resets password" do
	include SessionHelpers


	before(:each) do
			User.create(:email => "iforgot@password.com",
									:password => 'password',
									:password_confirmation => 'password')
	end

	scenario 'tries to reset password' do
		visit '/users/reset_password'
		expect(page).to have_content("Reset Password")
		fill_in 'email_reset', :with => "iforgot@password.com"
		click_button 'Reset'
		expect(page).to have_content("Please check your email for your password reset link.")
	end

		# this has to be a unit test in spec/
		# expect{User.password_token.length}.to eq(64)
		# expect{User.password_token_timestamp.strftime}.to eq(Time.now.strftime)

	scenario 'cannot sign in with old password' do
		visit '/'
		expect(page).not_to have_content("Welcome, test@test.com")
		sign_in("test@test.com", 'password')
		expect(page).not_to have_content("Welcome, test@test.com")
	end
end