module Refinery
  module Newsletter
    module Admin
      class CategoriesController < ::Refinery::AdminController

        crudify :'refinery/newsletter/category',
                :order => 'title ASC'

      end
    end
  end
end
