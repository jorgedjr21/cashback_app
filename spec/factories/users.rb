FactoryBot.define do
  factory :user do
    name { 'Name' }
    email { 'rspec@test.com'}
    password { 'my_password' }
  end
end
