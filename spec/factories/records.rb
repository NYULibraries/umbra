FactoryGirl.define do
  
  factory Umbra::Record do
    collection "VBL"
    title "MyRecord"
    
    trait :subject_controlled_list do
      after(:create) { |record| record.update_attributes(subject_controlled_list: 'Tag1') }
    end
    trait :extent_list do
      after(:create) { |record| record.update_attributes(extent_list: 'Tag1') }
    end
    trait :coverage_spatial_list do
      after(:create) { |record| record.update_attributes(coverage_spatial_list: 'Tag1') }
    end
    trait :coverage_temporal_list do
      after(:create) { |record| record.update_attributes(coverage_temporal_list: 'Tag1') }
    end
    trait :coverage_jurisdiction_list do
      after(:create) { |record| record.update_attributes(coverage_jurisdiction_list: 'Tag1') }
    end
    trait :source_list do
      after(:create) { |record| record.update_attributes(source_list: 'Tag1') }
    end
    trait :language_list do
      after(:create) { |record| record.update_attributes(language_list: 'Tag1') }
    end
    trait :accrualPeriodicity_list do
      after(:create) { |record| record.update_attributes(accrualPeriodicity_list: 'Tag1') }
    end
    trait :subject_tag_list do
      after(:create) { |record| record.update_attributes(subject_tag_list: 'Tag1') }
    end

    factory :record_with_subject_controlled_list, traits: [:subject_controlled_list]
    factory :record_with_extent_list, traits: [:extent_list]
    factory :record_with_coverage_spatial_list, traits: [:coverage_spatial_list]
    factory :record_with_coverage_temporal_list, traits: [:coverage_temporal_list]
    factory :record_with_coverage_jurisdiction_list, traits: [:coverage_jurisdiction_list]
    factory :record_with_source_list, traits: [:source_list]
    factory :record_with_language_list, traits: [:language_list]
    factory :record_with_accrualPeriodicity_list, traits: [:accrualPeriodicity_list]
    factory :record_with_subject_tag_list, traits: [:subject_tag_list]
    
  end
  
end