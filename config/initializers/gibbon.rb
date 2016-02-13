if Rails.env.test?
  #Gibbon::Export.api_key = "fake"
  #Gibbon::Export.throws_exceptions = false
else
	Gibbon::API.api_key = ENV['MAILCHIMP_API_KEY']
	if Rails.env.development?
		Gibbon::Export.throws_exceptions = true
	else
		Gibbon::Export.throws_exceptions = false
	end
end
