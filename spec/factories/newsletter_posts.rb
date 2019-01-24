FactoryGirl.define do
  factory :newsletter_post, :class => Refinery::Newsletter::Post do
    sequence(:title) { |n| "Top #{n} Shopping Centers in Chicago" }
    body "These are the top ten shopping centers in Chicago. You're going to read a long newsletter post about them. Come to peace with it."
    draft false
    tag_list "chicago, shopping, fun times"
    published_at Time.now
    
    factory :newsletter_post_draft do
      draft true
    end
  end
end
