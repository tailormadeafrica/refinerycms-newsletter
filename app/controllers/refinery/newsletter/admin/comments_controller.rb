module Refinery
  module Newsletter
    module Admin
      class CommentsController < ::Refinery::AdminController

        crudify :'refinery/newsletter/comment',
                :title_attribute => :name,
                :order => 'published_at DESC'

        def index
          @comments = Refinery::Newsletter::Comment.unmoderated.page(params[:page])

          render :action => 'index'
        end

        def approved
          unless params[:id].present?
            @comments = Refinery::Newsletter::Comment.approved.page(params[:page])

            render :action => 'index'
          else
            @comment = Refinery::Newsletter::Comment.find(params[:id])
            @comment.approve!
            flash[:notice] = t('approved', :scope => 'refinery.newsletter.admin.comments', :author => @comment.name)

            redirect_to refinery.url_for(:action => params[:return_to] || 'index', :id => nil)
          end
        end

        def rejected
          unless params[:id].present?
            @comments = Refinery::Newsletter::Comment.rejected.page(params[:page])

            render :action => 'index'
          else
            @comment = Refinery::Newsletter::Comment.find(params[:id])
            @comment.reject!
            flash[:notice] = t('rejected', :scope => 'refinery.newsletter.admin.comments', :author => @comment.name)

            redirect_to refinery.url_for(:action => params[:return_to] || 'index', :id => nil)
          end
        end

      end
    end
  end
end
