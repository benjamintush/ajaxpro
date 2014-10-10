class HomeController < ApplicationController
  def index
    @urls = Url.all
  end

  def urls
  end
end
