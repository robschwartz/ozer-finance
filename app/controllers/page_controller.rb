class PageController < ActionController::Base
  layout 'application'

  before_action :check_country

  def terms;end
  def privacy;end
  def about;end
  def thanks;end
  def contact;end

  def search_help
    form_version = ["a","b"]
    # form_version = ["b"]
    version = form_version.sample
    
    @location = params['location']

    puts version
    render "search_help_#{version}"
  end

  private
  
  def check_country
    accepted_countries = ["US", "CA"]
    ip = Ipstack::API.check
    puts ip['country_code']
    unless accepted_countries.include?(ip['country_code'])
      render "page/not_serviced" and return
    end
  rescue => e  
    puts "ERROR CHECKING COUNTRY #{e}"
  end

end
