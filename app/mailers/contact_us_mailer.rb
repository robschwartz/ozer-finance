class ContactUsMailer < ApplicationMailer
  default :from => 'noreply@ozer-health.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def contact(params)
    @message = params['message']
    mail( :to => "robertschwar@gmail.com",
    :subject => params['subject'] )
  end

  def lead_capture(params)
    @name = params["name"]
    @email = params["email"]
    @phone = params["phone"]
    @location = params["location"]
    mail( :to => "robertschwar@gmail.com",
    :subject => " $$$ New Lead $$$ ")
  end

  def thank_you(params)
    @name = params["name"]
    mail( :to => params["email"],
    :subject => "Your information has been received!")
  end
end
