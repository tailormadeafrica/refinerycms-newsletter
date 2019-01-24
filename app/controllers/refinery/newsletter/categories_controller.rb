module Refinery
  module Newsletter
    class CategoriesController < NewsletterController

      def show
        @category = Refinery::Newsletter::Category.find(params[:id])
        @posts = @category.posts.live.includes(:comments, :categories).page(params[:page])
      end

    end
  end
end
