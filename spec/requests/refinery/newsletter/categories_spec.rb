require "spec_helper"

module Refinery
  describe "NewsletterCategories" do
    login_refinery_user

    context "has one category and post" do
      before(:each) do
        @post = FactoryGirl.create(:newsletter_post, :title => "Refinery CMS newsletter post")
        @category = FactoryGirl.create(:newsletter_category, :title => "Video Games")
        @post.categories << @category
        @post.save!
      end

      describe "show categories newsletter posts" do
        before(:each) { visit refinery.newsletter_category_path(@category) }
        it "should displays categories newsletter posts" do
          page.should have_content("Refinery CMS newsletter post")
          page.should have_content("Video Games")
        end
      end
    end
  end
end
