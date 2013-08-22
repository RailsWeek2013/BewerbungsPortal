class Notification < ActionMailer::Base
  default from: "from@example.com"


  def new_account(profile)
  	@user = profile.user
  	@pr = profile
  	
  	attachments['defaul.jpg'] = File.read("#{Rails.root}/app/assets/images/default.jpg")

  	mail(:to => @user.email, :subject => "The new account #{@pr.name} is active.")

  end

  def send_cv(profile, file)
  	@user = profile.user
  	@file_path = file
  	
  	attachments["Document.pdf"] = File.read(@file_path)

  	mail(:to => @user.email, :subject => "Hey, we have delivered your documents :) !")
  end
end
