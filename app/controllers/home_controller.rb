class HomeController < ApplicationController
  def index
    @offers = Offer.where(enabled: true).order(:ends_at)
  end
end