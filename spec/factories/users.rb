FactoryBot.define do
  factory :user do
    name { 'Name' }
    email { 'rspec@test.com'}
    password { 'test' }
  end
end
