class HomeController < ApplicationController
  def about
  	@about = About.all
  end

  def privacy
  	@privacy = Privacy.all
  end

  def terms
  	@terms = Terms.all
  end

end
