require 'rails_helper'

RSpec.feature 'DisableOffers', type: :feature do
  let!(:user) { create(:user) }
  context 'with user logged' do
    before :each do
      sign_in user
    end

    context 'with offer to disable' do
      let!(:offer) { create(:offer, advertiser_name: 'Can Enable', enabled: true, starts_at: Time.zone.now - 3.hours) }

      it 'must disable the offer' do
        visit '/admin'
        click_link 'Disable'

        expect(page).to have_content("The offer #{offer.id} is disabled now")
        expect(page).to have_current_path(admin_path)
        expect(offer.reload.enabled?).to be_falsey
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
