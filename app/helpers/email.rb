module EmailSender

	def send_email(user)
		RestClient.post "https://api:key-b9d2ddeffe2814db3a84fd902e0db00a"\
		"@api.mailgun.net/v2/sandbox45a4bf305d004c17971ce53c3c23b15d.mailgun.org/messages",
  	:from => "postmaster@sandbox45a4bf305d004c17971ce53c3c23b15d.mailgun.org",
  	:to => "#{user.email}",
  	:subject => "Password Reset",
  	:text => "To reset your password, please visit http://localhost:9292/users/reset_password/#{user.password_token}"
	end

end