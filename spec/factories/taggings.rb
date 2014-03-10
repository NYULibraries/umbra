FactoryGirl.define do
  
  factory ActsAsTaggableOn::Tagging do
  
    factory :tagging do
      tag_id "1"
      taggable_id "1"
      taggable_type "Umbra::Record"
  
      factory :tagging_subject_controlled do
        context "subject_controlleds"
      end
  
      factory :tagging_extents do
  			context "extents"
      end
  
      factory :tagging_coverage_spatials do
  			context "coverage_spatials"
      end
  
      factory :tagging_coverage_temporals do
  			context "coverage_temporals"
      end
  
      factory :tagging_coverage_jurisdictions do
  			context "coverage_jurisdictions"
      end
  
      factory :tagging_sources do
  			context "sources"
      end
  
      factory :tagging_languages do
  			context "languages"
      end
  
      factory :tagging_accrualPeriodicities do
  			context "accrualPeriodicities"
      end
  
      factory :tagging_subject_tags do
  			context "subject_tags"
      end
    
    end
    
  end
end