require 'spec_helper'

module Refinery
  module Newsletter
    describe Comment do
      context "wiring up" do
        let(:comment) { FactoryGirl.create(:newsletter_comment) }

        it "saves" do
          comment.should_not be_nil
        end

        it "has a newsletter post" do
          comment.post.should_not be_nil
        end
      end
    end
  end
end
