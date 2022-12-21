# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email                { FactoryBot.next :email }
    password             { "password" }
    password_confirmation { "password" }
  end

  factory :email_confirmed_user, parent: :user do
    email_confirmed { true }
  end
end
