require 'rails_helper'

RSpec.feature 'EnableOffers', type: :feature do
  let!(:user) { create(:user) }
  context 'with user logged' do
    before :each do
      sign_in user
    end

    context 'with offer to enable' do
      let!(:offer) { create(:offer, advertiser_name: 'Can Enable', starts_at: Time.zone.now - 3.hours) }

      it 'must enable the offer' do
        visit '/admin'
        click_link 'Enable'

        expect(page).to have_content("The offer #{offer.id} is enabled now")
        expect(page).to have_current_path(admin_path)
        expect(offer.reload.enabled?).to be_truthy
      end
    end

    context 'when offer cant be enabled' do
      let!(:offer_2) { create(:offer, advertiser_name: 'Cant Enable', starts_at: Time.zone.now - 3.days, ends_at: Time.zone.now - 2.days) }

      it 'must not enable the offer' do
        visit '/admin'
        click_link 'Enable'

        expect(page).to have_content("The offer #{offer_2.id} 'ends_at' date already passed, please edit the offer")
        expect(page).to have_current_path(admin_path)
        expect(offer_2.reload.enabled?).to be_falsey
      end
    end
  end

  context 'with user not logged in' do
    it 'must redirect to sign_in page' do
      visit '/admin'
      expect(page).to have_content('You need to sign in or sign up before continuing.')
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
