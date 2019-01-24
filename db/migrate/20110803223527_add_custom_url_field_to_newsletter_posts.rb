class AddCustomUrlFieldToNewsletterPosts < ActiveRecord::Migration
  def change
    add_column Refinery::Newsletter::Post.table_name, :custom_url, :string
  end
end
