class CreateNewsletterStructure < ActiveRecord::Migration

  def up
    create_table Refinery::Newsletter::Post.table_name, :id => true do |t|
      t.string :title
      t.text :body
      t.boolean :draft
      t.datetime :published_at
      t.timestamps
    end

    add_index Refinery::Newsletter::Post.table_name, :id

    create_table Refinery::Newsletter::Comment.table_name, :id => true do |t|
      t.integer :newsletter_post_id
      t.boolean :spam
      t.string :name
      t.string :email
      t.text :body
      t.string :state
      t.timestamps
    end

    add_index Refinery::Newsletter::Comment.table_name, :id

    create_table Refinery::Newsletter::Category.table_name, :id => true do |t|
      t.string :title
      t.timestamps
    end

    add_index Refinery::Newsletter::Category.table_name, :id

    create_table Refinery::NewsletterCategorization.table_name, :id => true do |t|
      t.integer :newsletter_category_id
      t.integer :newsletter_post_id
    end

    add_index Refinery::NewsletterCategorization.table_name, [:newsletter_category_id, :newsletter_post_id], :name => 'index_newsletter_categories_newsletter_posts_on_bc_and_bp'
  end

  def down
    Refinery::UserPlugin.destroy_all({:name => "refinerycms_newsletter"})

    Refinery::Page.delete_all({:link_url => "/newsletter"})

    drop_table Refinery::Newsletter::Post.table_name
    drop_table Refinery::Newsletter::Comment.table_name
    drop_table Refinery::Newsletter::Category.table_name
    drop_table Refinery::NewsletterCategorization.table_name
  end

end
