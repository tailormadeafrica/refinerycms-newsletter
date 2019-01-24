class AddNewsletterSourceUrlToNewsletterPosts < ActiveRecord::Migration
  def change
    add_column Refinery::Newsletter::Post.table_name, :source_url, :string
    add_column Refinery::Newsletter::Post.table_name, :source_url_title, :string
    
  end
end
