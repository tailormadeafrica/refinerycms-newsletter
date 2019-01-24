class AddSlugToPostsAndCategories < ActiveRecord::Migration
  def change
    add_column Refinery::Newsletter::Post.table_name, :slug, :string
    add_index Refinery::Newsletter::Post.table_name, :slug

    add_column Refinery::Newsletter::Category.table_name, :slug, :string
    add_index Refinery::Newsletter::Category.table_name, :slug
  end
end