require "spec_helper"

module Refinery
  module Newsletter
    module Admin
      describe Comment do
        login_refinery_user

        describe "#index" do
          context "when has no new unapproved comments" do
            before(:each) do
              subject.class.delete_all
              visit refinery.newsletter_admin_comments_path
            end

            it "should list no comments" do
              visit refinery.newsletter_admin_comments_path

              page.should have_content('There are no new comments')
            end
          end
          context "when has new unapproved comments" do
            let!(:newsletter_comment) { FactoryGirl.create(:newsletter_comment) }
            before(:each) { visit refinery.newsletter_admin_comments_path }

            it "should list comments" do
              page.should have_content(newsletter_comment.body)
              page.should have_content(newsletter_comment.name)
            end

            it "should allow me to approve a comment" do
              click_link "Approve this comment"

              page.should have_content("has been approved")
            end

            it "should allow me to reject a comment" do
              click_link "Reject this comment"

              page.should have_content("has been rejected")
            end
          end
        end

        describe "#approved" do
          context "when has no approved comments" do
            before(:each) do
              subject.class.delete_all
              visit refinery.approved_newsletter_admin_comments_path
            end

            it "should list no comments" do
              page.should have_content('There are no approved comments')
            end
          end
          context "when has approved comments" do
            let!(:newsletter_comment) do
              FactoryGirl.create(:newsletter_comment, :state => 'approved')
            end
            before(:each) { visit refinery.approved_newsletter_admin_comments_path }

            it "should list comments" do
              page.should have_content(newsletter_comment.body)
              page.should have_content(newsletter_comment.name)
            end

            it "should allow me to reject a comment" do
              click_link "Reject this comment"

              page.should have_content("has been rejected")
            end
          end
        end

        describe "#rejected" do
          context "when has no rejected comments" do
            before(:each) do
              subject.class.delete_all
              visit refinery.rejected_newsletter_admin_comments_path
            end

            it "should list no comments" do
              page.should have_content('There are no rejected comments')
            end
          end
          context "when has rejected comments" do
            let!(:newsletter_comment) do
              FactoryGirl.create(:newsletter_comment, :state => 'rejected')
            end
            before(:each) { visit refinery.rejected_newsletter_admin_comments_path }

            it "should list comments" do
              page.should have_content(newsletter_comment.body)
              page.should have_content(newsletter_comment.name)
            end

            it "should allow me to approve a comment" do
              click_link "Approve this comment"

              page.should have_content("has been approved")
            end
          end
        end

        describe "#show" do
          let!(:newsletter_comment) { FactoryGirl.create(:newsletter_comment) }
          before(:each) { visit refinery.newsletter_admin_comment_path(newsletter_comment) }
          it "should display the comment" do
            page.should have_content(newsletter_comment.body)
            page.should have_content(newsletter_comment.name)
          end
          it "should allow me to approve the comment" do
            click_link "Approve this comment"

            page.should have_content("has been approved")
          end
        end
      end
    end
  end
end