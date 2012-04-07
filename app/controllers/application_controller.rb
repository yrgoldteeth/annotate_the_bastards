class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :cache_that_shit, :if => Rails.env.production?

  protected
  # Everything is static, and I would now just have built a static
  # generator using jekyll or whatevs.  This effectively handles 
  # it after any particular controller action gets loaded once
  # with the heroku varnish cache.
  def cache_that_shit
    response.headers['Cache-Control'] = 'public, max-age=31557600'
  end

end 
