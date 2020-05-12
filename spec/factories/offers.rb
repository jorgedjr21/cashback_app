FactoryBot.define do
  factory :offer do
    advertiser_name { 'Some Company' }
    url { 'http://teste.com' }
    description { 'description' }
    starts_at { '2020-05-12' }
    ends_at { '2020-05-18' }
    premium { false }
  end
end
