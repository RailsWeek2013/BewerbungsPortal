class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
  end

  def about
  end

  def contact
  end

  def download
    if(current_user.profile.nil?)
        redirect_to new_profile_path,
                  notice: "You need first to fill your profile ;)."
    else
  	   @incomplete_attributes = current_user.profile.incomplete_attributes
    end
  end
end
