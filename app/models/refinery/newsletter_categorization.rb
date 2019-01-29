module Refinery
  class NewsletterCategorization < ActiveRecord::Base

    self.table_name = 'refinery_newsletter_categories_newsletter_posts'
    belongs_to :newsletter_post, :class_name => 'Refinery::Newsletter::Post', :foreign_key => :newsletter_post_id
    belongs_to :newsletter_category, :class_name => 'Refinery::Newsletter::Category', :foreign_key => :newsletter_category_id
    
    attr_accessible :newsletter_category_id, :newsletter_post_id
  end
end