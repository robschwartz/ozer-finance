class ContactUsMailer < ApplicationMailer
  default :from => 'noreply@ozer-finance.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def contact(params)
    @message = params['message']
    mail( :to => "rob.ozerfinance@gmail.com",
    :subject => params['subject'] )
  end

  def lead_capture(params)
    puts params
    @params = params
    # @location = params["location"]
    mail( :to => "rob.ozerfinance@gmail.com",
    :subject => "New Lead")
  end

  def thank_you(params)
    puts params

    @name = params["name"]
    mail( :to => params["email"],
    :subject => "Your information has been received!")
  end
end
