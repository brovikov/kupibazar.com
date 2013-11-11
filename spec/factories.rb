# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :user do
    name     "Testov Test"
    email    "test@example.com"
    password "foobara"
    password_confirmation "foobara"
  end
end
