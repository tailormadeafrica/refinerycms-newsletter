module Refinery
  module Newsletter
    class Category < ActiveRecord::Base
      extend FriendlyId
      friendly_id :title, :use => [:slugged]

      has_many :newsletter_categorizations, :dependent => :destroy, :foreign_key => :newsletter_category_id
      has_many :posts, :through => :newsletter_categorizations, :source => :newsletter_post

      acts_as_indexed :fields => [:title]

      validates :title, :presence => true, :uniqueness => true

      attr_accessible :title

      def post_count
        posts.select(&:live?).count
      end

      # how many items to show per page
      self.per_page = Refinery::Newsletter.posts_per_page

    end
  end
end
