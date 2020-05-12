class Offer < ApplicationRecord
  validates :advertiser_name, presence: true, uniqueness: true, allow_blank: false
  validates :url, presence: true, allow_blank: false, url: true
  validates :description, presence: true, allow_blank: false, length: { maximum: 500 }
  validates :starts_at, presence: true, allow_blank: false
end
