class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
  end

  def about
  end

  def contact
  end

  def download
  	@incomplete_attributes = current_user.profile.incomplete_attributes
  end
end
