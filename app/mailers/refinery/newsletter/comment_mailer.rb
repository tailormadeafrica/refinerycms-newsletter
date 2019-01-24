module Refinery
  module Newsletter
    class CommentMailer < ActionMailer::Base

      def notification(comment, request)
        @comment = comment
        mail :subject => Newsletter::Comment::Notification.subject,
             :to => Newsletter::Comment::Notification.recipients,
             :from => "\"#{Refinery::Core.site_name}\" <no-reply@#{request.domain}>"
      end

    end
  end
end
