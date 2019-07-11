class PageController < ActionController::Base
  layout 'application'

  def terms;end
  def privacy;end
  def about;end
  def thanks;end
  def contact;end

  def search_help
    form_version = ["a","b"]
    version = form_version.sample
    
    @location = params['location']

    puts version
    render "search_help_#{version}"
  end

end
