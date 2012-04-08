class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  # Everything is static, and I would now just have built a static
  # generator using jekyll or whatevs.  This effectively handles 
  # it after any particular controller action 
  def cache_that_shit
    response.headers['Cache-Control'] = 'public, max-age=31557600'
  end

end 
