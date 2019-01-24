module Refinery
  module Newsletter
    class NewsletterController < ::ApplicationController

      include ControllerHelper

      helper :'refinery/newsletter/posts'
      before_filter :find_page, :find_all_newsletter_categories

      protected

        def find_page
          @page = Refinery::Page.find_by_link_url(Refinery::Newsletter.page_url)
        end
    end
  end
end
