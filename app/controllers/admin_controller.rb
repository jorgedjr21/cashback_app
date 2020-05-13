class AdminController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @offers = Offer.all
  end
end