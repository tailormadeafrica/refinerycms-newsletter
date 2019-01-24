module Refinery
  module Newsletter
    module ControllerHelper
    
      protected
    
        def find_newsletter_post
          unless (@post = Refinery::Newsletter::Post.find(params[:id])).try(:live?)
            if refinery_user? and current_refinery_user.authorized_plugins.include?("refinerycms_newsletter")
              @post = Refinery::Newsletter::Post.find(params[:id])
            else
              error_404
            end
          end
        end
    
        def find_all_newsletter_posts
          @posts = Refinery::Newsletter::Post.live.includes(:comments, :categories).page(params[:page])
        end

        def find_tags
          @tags = Refinery::Newsletter::Post.tag_counts_on(:tags)
        end
        def find_all_newsletter_categories
          @categories = Refinery::Newsletter::Category.all
        end
    end
  end
end
