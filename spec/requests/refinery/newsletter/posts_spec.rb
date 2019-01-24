require "spec_helper"

module Refinery
  describe "Newsletter::Posts" do
    login_refinery_user
  
    context "when has newsletter posts" do    
      let!(:newsletter_post) { FactoryGirl.create(:newsletter_post, :title => "Refinery CMS newsletter post") }
    
      it "should display newsletter post" do
        visit refinery.newsletter_post_path(newsletter_post)
        
        page.should have_content(newsletter_post.title)
      end
    
      it "should display the newsletter rss feed" do
        get refinery.newsletter_rss_feed_path
        
        response.should be_success
        response.content_type.should eq("application/rss+xml")
      end
    end
      
    describe "list tagged posts" do    
      context "when has tagged newsletter posts" do      
        before(:each) do
          @tag_name = "chicago"
          @post = FactoryGirl.create(:newsletter_post,
                                          :title => "I Love my city",
                                          :tag_list => @tag_name)
          @tag = ::Refinery::Newsletter::Post.tag_counts_on(:tags).first          
        end
        it "should have one tagged post" do
          visit refinery.newsletter_tagged_posts_path(@tag.id, @tag_name.parameterize)
          
          page.should have_content(@tag_name)
          page.should have_content(@post.title)
        end
      end
    end
    
    describe "#show" do
      context "when has no comments" do
        let(:newsletter_post) { FactoryGirl.create(:newsletter_post) }
        
        it "should display the newsletter post" do
          visit refinery.newsletter_post_path(newsletter_post)
          page.should have_content(newsletter_post.title)
          page.should have_content(newsletter_post.body)
        end
      end
      context "when has approved comments" do
        let(:approved_comment) { FactoryGirl.create(:approved_comment) }
        
        it "should display the comments" do
          visit refinery.newsletter_post_path(approved_comment.post)
          
          page.should have_content(approved_comment.body)
          page.should have_content("Posted by #{approved_comment.name}")
        end
      end
      context "when has rejected comments" do
        let(:rejected_comment) { FactoryGirl.create(:rejected_comment) }
        
        it "should not display the comments" do          
          visit refinery.newsletter_post_path(rejected_comment.post)
          
          page.should_not have_content(rejected_comment.body)
        end
      end
      context "when has new comments" do
        let(:newsletter_comment) { FactoryGirl.create(:newsletter_comment) }
        
        it "should not display the comments" do
          visit refinery.newsletter_post_path(newsletter_comment.post)
          
          page.should_not have_content(newsletter_comment.body)
        end
      end

      context "when posting comments" do
        let(:newsletter_post) { Factory(:newsletter_post) }
        let(:name) { "pete" }
        let(:email) { "pete@mcawesome.com" }
        let(:body) { "Witty comment." }

        before do
          visit refinery.newsletter_post_path(newsletter_post)

          fill_in "Name", :with => name
          fill_in "Email", :with => email
          fill_in "Message", :with => body
          click_button "Send comment"
        end

        it "creates the comment" do
          comment = newsletter_post.reload.comments.last

          comment.name.should eq(name)
          comment.email.should eq(email)
          comment.body.should eq(body)
        end
      end

      context "post popular" do
        let(:newsletter_post) { FactoryGirl.create(:newsletter_post) }
        let(:newsletter_post2) { FactoryGirl.create(:newsletter_post) }

        before do
          visit refinery.newsletter_post_path(newsletter_post)
        end

        it "should increment access count" do
          newsletter_post.reload.access_count.should eq(1)
          visit refinery.newsletter_post_path(newsletter_post)
          newsletter_post.reload.access_count.should eq(2)
        end

        it "should be most popular" do
          Refinery::Newsletter::Post.popular(2).first.should eq(newsletter_post)
        end
      end

      context "post recent" do
        let(:newsletter_post) { FactoryGirl.create(:newsletter_post) }
        let(:newsletter_post2) { FactoryGirl.create(:newsletter_post) }

        before do
          visit refinery.newsletter_post_path(newsletter_post2)
          visit refinery.newsletter_post_path(newsletter_post)
        end

        it "should be the most recent" do
          Refinery::Newsletter::Post.recent(2).first.should eq(newsletter_post2)
        end
      end

    end

    describe "#show draft preview" do
      let(:newsletter_post) { FactoryGirl.create(:newsletter_post_draft) }
      context "when logged in as admin" do        
        it "should display the draft notification" do
          visit refinery.newsletter_post_path(newsletter_post)
          
          page.should have_content('This page is NOT live for public viewing.')
        end
      end
      context "when not logged in as an admin" do
        before(:each) { visit refinery.destroy_refinery_user_session_path }
        
        it "should not display the newsletter post" do
          visit refinery.newsletter_post_path(newsletter_post)
          
          page.should have_content("The page you were looking for doesn't exist (404)")
        end
      end
    end
  end
end
