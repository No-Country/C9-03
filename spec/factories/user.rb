FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    name { Faker::Name.unique }
    password { 'password' }
    password_confirmation { 'password' }
  end
end