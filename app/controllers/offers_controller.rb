class OffersController < ApplicationController
  before_action :authenticate_user!

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)

    if @offer.save
      redirect_to admin_path, flash: { notice: 'Offer created with success!' }
    else
      flash[:error] = 'Some errors occured when trying to create a new offer'
      render :new
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:advertiser_name, :url, :description, :starts_at, :ends_at, :premium)
  end
end