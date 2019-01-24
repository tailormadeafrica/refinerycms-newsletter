module Refinery
  module Newsletter
    class PostsController < NewsletterController

      before_filter :find_all_newsletter_posts, :except => [:archive]
      before_filter :find_newsletter_post, :only => [:show, :comment, :update_nav]
      before_filter :find_tags

      respond_to :html, :js, :rss

      def index
        if request.format.rss?
          @posts = Post.live.includes(:comments, :categories)
          # limit rss feed for services (like feedburner) who have max size
          @posts = Post.recent(params["max_results"]) if params["max_results"].present?
        end
        respond_with (@posts) do |format|
          format.html
          format.rss
        end
      end

      def show
        @comment = Comment.new

        @canonical = url_for(:locale => ::Refinery::I18n.default_frontend_locale) if canonical?

        @post.increment!(:access_count, 1)

        respond_with (@post) do |format|
          format.html { present(@post) }
          format.js { render :partial => 'post', :layout => false }
        end
      end

      def comment
        if (@comment = @post.comments.create(params[:comment])).valid?
          if Comment::Moderation.enabled? or @comment.ham?
            begin
              CommentMailer.notification(@comment, request).deliver
            rescue
              logger.warn "There was an error delivering a newsletter comment notification.\n#{$!}\n"
            end
          end

          if Comment::Moderation.enabled?
            flash[:notice] = t('thank_you_moderated', :scope => 'refinery.newsletter.posts.comments')
            redirect_to refinery.newsletter_post_url(params[:id])
          else
            flash[:notice] = t('thank_you', :scope => 'refinery.newsletter.posts.comments')
            redirect_to refinery.newsletter_post_url(params[:id],
                                      :anchor => "comment-#{@comment.to_param}")
          end
        else
          render :action => 'show'
        end
      end

      def archive
        if params[:month].present?
          date = "#{params[:month]}/#{params[:year]}"
          @archive_date = Time.parse(date)
          @date_title = @archive_date.strftime('%B %Y')
          @posts = Post.live.by_archive(@archive_date).page(params[:page])
        else
          date = "01/#{params[:year]}"
          @archive_date = Time.parse(date)
          @date_title = @archive_date.strftime('%Y')
          @posts = Post.live.by_year(@archive_date).page(params[:page])
        end
        respond_with (@posts)
      end

      def tagged
        @tag = ActsAsTaggableOn::Tag.find(params[:tag_id])
        @tag_name = @tag.name
        @posts = Post.tagged_with(@tag_name).page(params[:page])
      end

      def canonical?
        ::Refinery.i18n_enabled? && ::Refinery::I18n.default_frontend_locale != ::Refinery::I18n.current_frontend_locale
      end
    end
  end
end
