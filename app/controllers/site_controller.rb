class SiteController < ApplicationController
  def index
    render :no_access if current_user && !current_user.tipycal?
  end
end
