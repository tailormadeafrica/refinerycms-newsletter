require "spec_helper"

module Refinery
  module Newsletter
    describe PostsController do
      login_refinery_user

      before do
        FactoryGirl.create(:newsletter_post, :title => "newsletterpost_one")
        FactoryGirl.create(:newsletter_post, :title => "newsletterpost_two")
        FactoryGirl.create(:newsletter_post, :title => "newsletterpost_three")
      end

      it "should not limit rss feed" do
        get :index, :format => :rss
        assigns[:posts].size.should == 3
      end

      it "should limit rss feed" do
        get :index, :format => :rss, :max_results => 2
        assigns[:posts].count.should == 2
      end
    end
  end
end

