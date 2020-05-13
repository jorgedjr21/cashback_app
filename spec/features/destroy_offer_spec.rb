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
end
