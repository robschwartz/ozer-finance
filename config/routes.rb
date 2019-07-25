Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'provider#home'

  get '/adult-home-finder', to: 'provider#home', as: 'home'

  get'/adult-home-finder/adult-homes/:location', to: 'provider#location_results', as: 'location'

  get'/adult-home-finder/adult-home/:name', to: 'provider#show', as: 'provider_page'

  # form requests
  post '/provider/search', to: 'provider#search'

  post '/request_info', to: 'provider#request_info'
  post '/provider/request_info', to: 'provider#request_info'

  post '/send-contact-form', to: 'provider#send_contact_form'

  # info pages

  get '/terms', to: 'page#terms'
  get '/privacy', to: 'page#privacy'
  get '/about', to: 'page#about'
  get '/thank-you', to: 'page#thanks'
  get '/contact', to: 'page#contact'
  get '/search-help', to: 'page#search_help'

  get "/sitemap.xml" => "sitemap#index", :format => "xml", :as => :sitemap
end
