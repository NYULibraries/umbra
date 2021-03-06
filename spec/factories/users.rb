FactoryGirl.define do

  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "#{username}@example.com" }
    provider 'nyulibraries'
    firstname 'Dev'
    lastname 'Eloper'
    institution_code "NYU"
    aleph_id { (ENV['BOR_ID'] || 'BOR_ID') }

    trait :nyu_aleph_attributes do
      status { '51' }
    end

    factory :user_without_admin_collections do
      admin true
    end

    factory :user_with_non_array_admin_collections do
      admin true
      admin_collections "global"
    end

    factory :user_with_admin_collections do
      admin true
      admin_collections ["VBL", "DataServices"]
    end

    factory :non_admin do
      admin_collections []
    end

  end

end
