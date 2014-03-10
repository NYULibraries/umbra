FactoryGirl.define do
  
  factory Umbra::Record do
    
    collection "VBL"
    name "MyRecord"
    
    factory :record_with_subject_controlleds do
        
      after(:create) do |record, evaluator|
        create(:tagging_subject_controlled, taggable: record)
      end
    
    end
  
  end
  
end