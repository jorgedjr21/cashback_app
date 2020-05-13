require 'rails_helper'

RSpec.describe OffersController, type: :controller do
  let!(:user) { create(:user) }
  describe 'POST /offers' do
    context 'signed_in' do
      context 'with valid attributes' do
        before :each do
          sign_in user
        end

        let(:valid_attributes) do
          {
            offer: {
              advertiser_name: 'Company Name',
              url: 'http://test.com',
              description: 'Offer Description',
              starts_at: '20/05/2020'
            }
          }
        end

        it 'must create a new offer' do
          expect { post :create, params: valid_attributes }.to change(Offer, :count).by(1)
        end

        it 'must redirect to admin page' do
          expect(post(:create, params: valid_attributes)).to redirect_to(admin_path)
        end
      end

      context 'with invalid attributes' do
        let!(:offer) { create(:offer, advertiser_name: 'company_name')}
        let(:valid_attributes) do
          {
            offer: {
              advertiser_name: 'company_name',
              url: 'http://test.com',
              description: '',
              starts_at: '20/05/2020'
            }
          }
        end

        it 'must not create a new offer' do
          expect { post :create, params: valid_attributes }.not_to change(Offer, :count)
        end
      end
    end
  end
end
