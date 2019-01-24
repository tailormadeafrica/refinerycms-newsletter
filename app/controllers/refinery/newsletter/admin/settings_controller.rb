module Refinery
  module Newsletter
    module Admin
      class SettingsController < ::Refinery::AdminController

        def notification_recipients
          @recipients = Refinery::Newsletter::Comment::Notification.recipients

          if request.post?
            Refinery::Newsletter::Comment::Notification.recipients = params[:recipients]
            flash[:notice] = t('updated', :scope => 'refinery.newsletter.admin.settings.notification_recipients',
                               :recipients => Refinery::Newsletter::Comment::Notification.recipients)
            unless request.xhr? or from_dialog?
              redirect_back_or_default(refinery.newsletter_admin_posts_path)
            else
              render :text => "<script type='text/javascript'>parent.window.location = '#{refinery.newsletter_admin_posts_path}';</script>",
                     :layout => false
            end
          end
        end

        def moderation
          enabled = Refinery::Newsletter::Comment::Moderation.toggle!
          unless request.xhr?
            redirect_back_or_default(refinery.newsletter_admin_posts_path)
          else
            render :json => {:enabled => enabled},
                   :layout => false
          end
        end

        def comments
          enabled = Refinery::Newsletter::Comment.toggle!
          unless request.xhr?
            redirect_back_or_default(refinery.newsletter_admin_posts_path)
          else
            render :json => {:enabled => enabled},
                   :layout => false
          end
        end

        def teasers
          enabled = Refinery::Newsletter::Post.teaser_enabled_toggle!
          unless request.xhr?
            redirect_back_or_default(refinery.newsletter_admin_posts_path)
          else
            render :json => {:enabled => enabled},
                   :layout => false
          end
        end

      end
    end
  end
end