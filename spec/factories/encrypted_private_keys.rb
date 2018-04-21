FactoryBot.define do
  factory :encrypted_private_key do
    user
    key 'my_kidney'
  end
end
