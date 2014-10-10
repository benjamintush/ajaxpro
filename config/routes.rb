Rails.application.routes.draw do
  root 'urls#index'
  resources :urls

  # match "/application.manifest" => Rails::Offline, via: [:get, :post]

  # cache ActionController::Base.helpers.asset_path("offline_mode.js")

  offline = Rack::Offline.configure :cache_interval => 120 do
    #cache "images/masthead.png"
    cache ActionController::Base.helpers.asset_path("application.js")
    cache ActionController::Base.helpers.asset_path("jquery.js")
    cache ActionController::Base.helpers.asset_path("jquery_ujs.js")
    cache ActionController::Base.helpers.asset_path("jquery.tmpl.min.js")
    cache ActionController::Base.helpers.asset_path("jquery.offline.js")
    cache ActionController::Base.helpers.asset_path("json.js")
    cache ActionController::Base.helpers.asset_path("custom.js")
    cache ActionController::Base.helpers.asset_path("validate.js")
    cache ActionController::Base.helpers.asset_path("application.css")
    cache ActionController::Base.helpers.asset_path("style.css")
    cache ActionController::Base.helpers.asset_path("custom.css")

    network "/"
  end
  get "/application.manifest" => offline

end