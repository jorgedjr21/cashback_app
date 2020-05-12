require 'rails_helper'

RSpec.describe Offer, type: :model do
  describe 'validations' do
    context 'advertiser_name' do
      it 'must be informed' do
        nice_offer = build(:offer)
        wrong_offer = build(:offer, advertiser_name: '')

        expect { nice_offer.save }.to change(Offer, :count).by(1)
        expect { wrong_offer.save }.not_to change(Offer, :count)
        expect(Offer.last).to eq(nice_offer)
      end

      it 'must be unique' do
        nice_offer = build(:offer, advertiser_name: 'name')
        wrong_offer = build(:offer, advertiser_name: 'name')

        expect { nice_offer.save }.to change(Offer, :count).by(1)
        expect { wrong_offer.save }.not_to change(Offer, :count)
        expect(Offer.last).to eq(nice_offer)
      end
    end

    context 'url' do
      it 'must be informed' do
        nice_offer = build(:offer, url: 'http://test.com')
        wrong_offer = build(:offer, url: '')

        expect { nice_offer.save }.to change(Offer, :count).by(1)
        expect { wrong_offer.save }.not_to change(Offer, :count)
        expect(Offer.last).to eq(nice_offer)
      end

      it 'must have valid url' do
        nice_offer = build(:offer, url: 'http://test.com')
        wrong_offer = build(:offer, url: 'wrong-url')

        expect(nice_offer.valid?).to be_truthy
        expect(wrong_offer.valid?).to be_falsey
      end
    end

    context 'description' do
      it 'must be informed' do
        nice_offer = build(:offer)
        wrong_offer = build(:offer, description: '')

        expect { nice_offer.save }.to change(Offer, :count).by(1)
        expect { wrong_offer.save }.not_to change(Offer, :count)
        expect(Offer.last).to eq(nice_offer)
      end

      it 'must have only 500 chars or less' do
        nice_offer = build(:offer)
        wrong_offer = build(:offer, description: (1..560).map { |_n| 'a' }.join(''))

        expect { nice_offer.save }.to change(Offer, :count).by(1)
        expect { wrong_offer.save }.not_to change(Offer, :count)
        expect(Offer.last).to eq(nice_offer)
      end
    end

    context 'starts_at' do
      it 'must be informed' do
        nice_offer = build(:offer)
        wrong_offer = build(:offer, starts_at: '')

        expect { nice_offer.save }.to change(Offer, :count).by(1)
        expect { wrong_offer.save }.not_to change(Offer, :count)
        expect(Offer.last).to eq(nice_offer)
      end
    end
  end
end
