require 'ffaker'

FactoryBot.define do
  factory :play do
    timer { rand(1..10) }
    url { FFaker::Avatar.image }
  end
end