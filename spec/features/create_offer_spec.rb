require 'rails_helper'

RSpec.feature 'CreateOffers Page', type: :feature do
  let!(:user) { create(:user) }
  context 'with user logged' do
    before :each do
      sign_in user
    end

    context 'with form filled_in correctly' do
      it 'must create offer with correct data in form' do
        visit '/offers/new'

        fill_in 'offer_advertiser_name', with: 'Offer Name'
        fill_in 'offer_url', with: 'http://test.com'
        fill_in 'offer_description', with: 'Offer Name'
        fill_in 'offer_starts_at', with: '10/01/2020'
        fill_in 'offer_ends_at', with: ''
        click_button 'Create Offer'

        expect(page).to have_content('Offer created with success!')
        expect(page).to have_content('Offer Name')
        expect(page).to have_current_path(admin_path)
      end
    end

    context 'when form is filled_in incorrectly' do
      it 'must show the errors' do
        visit '/offers/new'

        fill_in 'offer_advertiser_name', with: ''
        fill_in 'offer_url', with: ''
        fill_in 'offer_description', with: ''
        fill_in 'offer_starts_at', with: ''
        fill_in 'offer_ends_at', with: ''
        click_button 'Create Offer'

        expect(page).to have_content('Advertiser name can\'t be blank')
        expect(page).to have_content('Url can\'t be blank and Url is not a valid URL')
        expect(page).to have_content('Description can\'t be blank and Description is too short (minimum is 1 character)')
        expect(page).to have_content('Starts at can\'t be blank')
        expect(page).to have_current_path(offers_path)
      end
    end
  end

  context 'when user not logged_in' do
    it 'must redirect to sign_in page' do
      visit '/offers/new'

      expect(page).to have_content('You need to sign in or sign up before continuing.')
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
