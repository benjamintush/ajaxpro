Rails.application.routes.draw do
  root 'urls#index'
  # root 'home#index'
  resources :urls
  get "home",  to: "home#index"

  # match "/application.manifest" => Rails::Offline, via: [:get, :post]

  # cache ActionController::Base.helpers.asset_path("offline_mode.js")

  offline = Rack::Offline.configure :cache_interval => 120 do
    #cache "images/masthead.png"
    cache ActionController::Base.helpers.asset_path("jquery.js?body=1")
    cache ActionController::Base.helpers.asset_path("jquery_ujs.js?body=1")
    cache ActionController::Base.helpers.asset_path("jquery.tmpl.min.js?body=1")
    cache ActionController::Base.helpers.asset_path("jquery.offline.js?body=1")
    cache ActionController::Base.helpers.asset_path("json.js?body=1")
    cache ActionController::Base.helpers.asset_path("custom.js?body=1")
    cache ActionController::Base.helpers.asset_path("validate.js?body=1")
    cache ActionController::Base.helpers.asset_path("application.js?body=1")
    cache ActionController::Base.helpers.asset_path("style.css?body=1")
    cache ActionController::Base.helpers.asset_path("custom.css?body=1")
    cache ActionController::Base.helpers.asset_path("application.css?body=1")
    network "*"
  end
  # get "/application.manifest" => offline
  match "/application.manifest" => offline, via: [:get, :post]

end