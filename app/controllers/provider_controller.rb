class ProviderController < ActionController::Base
  layout 'application'

  before_action :check_country

  def root
    @states = CS.states(:us)
    set_title_tag
  end

  def home
    @states = CS.states(:us)
    set_title_tag
  end

  def search
    p params
    redirect_to search_help_path(amount: params['amount'])
  end

  def request_info
    # Send data from the form to our data-bucket
    # if verify_recaptcha(model: nil) || params['home_form']
      ForwardData.send_to_bucket(params)
      ContactUsMailer.lead_capture(params['loan_lead']).deliver_now
      ContactUsMailer.thank_you(params['loan_lead']).deliver_now

      redirect_to thank_you_path and return 
    # end
  rescue => e
    puts "ERROR CAPTURING LEAD: #{e}"
    redirect_to thank_you_path and return 
  end

  def send_contact_form
    ContactUsMailer.contact(params).deliver_now
  end

  def location_results
    redirect_to search_help_path
  end

  def show
    @home = Provider.find_by_name(params['name'])
    @state = CS.states(:us)[@home.state.to_sym]
    set_title_tag
  end


  private

  def set_title_tag
    "Get your business loan approved in 24 hours or less"
  end
  
  def check_country
    accepted_countries = ["US", "CA"]
    puts "Forwarded IP: #{request.remote_ip}"
    # Ipstack::API.standard('134.201.250.155')
    ip = Ipstack::API.check
    puts "IP object: #{ip}"
    puts "Country Code: #{ip['country_code']}"
    unless accepted_countries.include?(ip['country_code'])
      render "page/not_serviced" and return
    end
  rescue => e  
    puts "ERROR CHECKING COUNTRY #{e}"
  end


end
