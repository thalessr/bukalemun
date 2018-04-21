# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username 'Garage 48'
    password '12345678'
    password_confirmation '12345678'
    role 'doctor'
  end
end
