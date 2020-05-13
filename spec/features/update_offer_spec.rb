require 'rails_helper'

RSpec.feature 'UpdateOffers', type: :feature do
  let!(:user) { create(:user) }
  context 'with user logged' do
    before :each do
      sign_in user
    end

    context 'with offer to update' do
      let!(:offer) { create(:offer, advertiser_name: 'Can Enable') }

      it 'must enable the offer' do
        visit '/admin'
        click_link 'Edit'

        fill_in 'offer_advertiser_name', with: 'Updated Name'
        fill_in 'offer_description', with: 'Updated Description'
        click_button 'Save'

        expect(page).to have_content("Offer #{offer.id} updated with success!")
        expect(page).to have_current_path(admin_path)
        expect(offer.reload.advertiser_name).to eq('Updated Name')
        expect(offer.description).to eq('Updated Description')
      end
    end
  end
end
