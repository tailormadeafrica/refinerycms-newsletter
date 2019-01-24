FactoryGirl.define do
  factory :newsletter_category, :class => Refinery::Newsletter::Category do
    sequence(:title) { |n| "Shopping #{n}" }
  end
end
