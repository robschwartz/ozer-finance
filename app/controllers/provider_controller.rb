class ProviderController < ActionController::Base
  layout 'application'

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
    redirect_to location_path(location: params['search'], home_type: params['home_type'])
  end

  def request_info
    # Send data from the form to our data-bucket
    if verify_recaptcha(model: nil) || params['home_form']
      ForwardData.send_to_bucket(params)
      ContactUsMailer.lead_capture(params['loan_lead']).deliver_now
      ContactUsMailer.thank_you(params['loan_lead']).deliver_now

      redirect_to thank_you_path and return 
    end
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
    @title = if !@location.blank?
              "Nursing Homes And Assisted Living Facilities Near #{@location}"
            elsif !@state.blank?
              "Nursing Homes, Assisted Living Facilities, Intermediate Care #{@state}"
            else
              "Nursing Homes, Assisted Living Facilities, Intermediate Care Near You"
            end
  end


end
