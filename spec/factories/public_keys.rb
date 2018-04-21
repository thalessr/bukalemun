FactoryBot.define do
  factory :public_key do
    user
    key 'my_super_key'
  end
end
