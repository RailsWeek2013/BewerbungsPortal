class Notification < ActionMailer::Base
  default from: "from@example.com"


  def new_account(user)
  	@user = user
  	
  	attachments['defaul.jpg'] = File.read("#{Rails.root}/app/assets/images/default.jpg")

  	mail(:to => "ilja.michajlow@mni.thm.de", :subject => "The new account #{@user.name} is active.")

  end
end
