require 'rails_helper'

RSpec.describe OffersController, type: :controller do
  let!(:user) { create(:user) }

  describe 'PUT offers/:id' do
    let!(:offer) { create(:offer) }
    context 'signed_in' do
      before :each do
        sign_in user
      end

      context 'when offer exists' do
        it 'must update the offer' do
          params = { id: offer.id,  offer: { advertiser_name: 'New Name' } }
          put :update, params: params

          expect(offer.reload.advertiser_name).to eq('New Name')
        end
      end

      context 'when offer doesn\'t exists' do
        it 'must redirect to admin page' do
          put :update, params: { id: 999 }
          expect(response).to redirect_to(admin_path)
        end
      end
    end

    context 'not signed in' do
      it 'must not allow user access' do
        params = { id: offer.id,  offer: { advertiser_name: 'New Name' } }
        put :update, params: params

        expect(response).to redirect_to(new_user_session_path)

      end
    end
  end

  describe 'DELETE /offers' do
    let!(:offer) { create(:offer) }
    context 'signed_in' do
      before :each do
        sign_in user
      end

      context 'when offer exists' do
        it 'must destroy the offer' do
          expect { delete :destroy, params: { id: offer.id } }.to change(Offer, :count).by(-1)
        end
      end

      context 'when offer doesn\'t exists' do
        it 'must not destroy the offer' do
          expect { delete :destroy, params: { id: rand(1..999) } }.not_to change(Offer, :count)
        end
      end
    end

    context 'not signed_in' do
      it 'must redirect to login page' do
        expect(delete(:destroy, params: { id: offer.id })).to redirect_to(new_user_session_path)
      end

      it 'must not destroy the offer' do
        expect { delete :destroy, params: { id: offer.id } }.not_to change(Offer, :count)
      end
    end
  end

  describe 'PUT /enable' do
    let!(:offer) { create(:offer, advertiser_name: 'Can Enable', starts_at: Time.zone.now - 3.hours) }
    let!(:offer_2) { create(:offer, advertiser_name: 'Cant Enable', starts_at: Time.zone.now - 3.days, ends_at: Time.zone.now - 2.days) }
    
    context 'signed_in' do
      before :each do
        sign_in user
      end

      context 'when offer can be enabled' do
        it 'must enable the offer' do
          put :enable, params: { id: offer.id }

          expect(offer.reload.enabled).to be_truthy
        end
      end

      context 'when offer cant be enabled' do
        it 'must doesnt enable the offer' do
          put :enable, params: { id: offer_2.id }

          expect(offer_2.reload.enabled).to be_falsey
        end
      end
    end
  end

  describe 'POST /offers' do
    context 'not signed_in' do
      context 'with valid attributes' do
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

        it 'must not create the offer' do
          expect { post :create, params: valid_attributes }.not_to change(Offer, :count)
        end

        it 'must redirect to login page' do
          expect(post(:create, params: valid_attributes)).to redirect_to(new_user_session_path)
        end
      end
    end

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
        let!(:offer) { create(:offer, advertiser_name: 'company_name') }
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
