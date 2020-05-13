class OffersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_offer, only: :destroy

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

  def destroy
    message =
      if @offer.present? && @offer.destroy
        { notice: 'Offer destroyed with success!' }
      else
        { error: 'Cant destroy the Offer please try again!' }
      end

    redirect_to admin_path, flash: message
  end

  private

  def set_offer
    @offer = Offer.find_by(id: params[:id])
  end

  def offer_params
    params.require(:offer).permit(:advertiser_name, :url, :description, :starts_at, :ends_at, :premium)
  end
end