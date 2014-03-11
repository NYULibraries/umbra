FactoryGirl.define do
  
  factory User do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "#{username}@example.com" }
    
    factory :user_without_admin_collections do
      user_attributes { {
          :umbra_admin => true
      } }
    end
    
    factory :user_with_non_array_admin_collections do
      user_attributes { {
          :umbra_admin => true,
          :umbra_admin_collections => "global"
      } }
    end
    
    factory :user_with_admin_collections do
      user_attributes { {
          :umbra_admin => true,
          :umbra_admin_collections => ["VBL", "DataServices"],
      } }
    end
    
  end
  
end