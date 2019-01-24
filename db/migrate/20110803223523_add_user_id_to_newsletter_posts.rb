class AddUserIdToNewsletterPosts < ActiveRecord::Migration

  def change
    add_column Refinery::Newsletter::Post.table_name, :user_id, :integer
  end

end