require 'rails_helper'

RSpec.feature "DestroyOffers", :js => true, type: :feature do
  let!(:user) { create(:user) }
  let!(:offer) { create(:offer) }
  context 'with user logged' do
    before :each do
      sign_in user
    end

    context 'clicking in destroy offer' do
      it 'must destroy the offer' do
        visit '/admin'
        click_link 'Destroy'
        page.driver.browser.switch_to.alert.accept
      
        expect(page).to have_content('Offer destroyed with success!')
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
