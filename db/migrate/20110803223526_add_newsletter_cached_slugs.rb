class AddNewsletterCachedSlugs < ActiveRecord::Migration
  def change
    add_column Refinery::Newsletter::Category.table_name, :cached_slug, :string
    add_column Refinery::Newsletter::Post.table_name, :cached_slug, :string
  end
end
