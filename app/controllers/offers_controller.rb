class OffersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_offer, only: %i[destroy enable disable]

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)

    if @offer.save
      redirect_to admin_path, flash: { notice: 'Offer created with success!' }
    else
      flash[:alert] = 'Some errors occured when trying to create a new offer'
      render :new
    end
  end

  def destroy
    message =
      if @offer.destroy
        { notice: 'Offer destroyed with success!' }
      else
        { alert: 'Cant destroy the Offer please try again!' }
      end

    redirect_to admin_path, flash: message
  end

  def enable
    if @offer.ends_at.present? && Time.zone.now > @offer.ends_at
      redirect_to admin_path, flash: { alert: "The offer #{@offer.id} 'ends_at' date already passed, please edit the offer" }
    else
      @offer.update!(enabled: true)
      redirect_to admin_path, flash: { notice: "The offer #{@offer.id} is enabled now" }
    end
  end

  def disable
    if @offer.update(enabled: false)
      redirect_to admin_path, flash: { notice: "The offer #{@offer.id} is disabled now" }
    else
      redirect_to admin_path, flash: { alert: "Can't disable the offer #{@offer.id}, please, try" }
    end
  end

  private

  def set_offer
    @offer = Offer.find_by(id: params[:id])
    redirect_to admin_path, flash: { alert: 'Offer not found!' } if @offer.blank?
  end

  def offer_params
    params.require(:offer).permit(:advertiser_name, :url, :description, :starts_at, :ends_at, :premium)
  end
end