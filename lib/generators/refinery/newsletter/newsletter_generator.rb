module Refinery
  class NewsletterGenerator < Rails::Generators::Base

    source_root File.expand_path("../templates", __FILE__)

    def generate_newsletter_initializer
      template "config/initializers/refinery/newsletter.rb.erb", File.join(destination_root, "config", "initializers", "refinery", "newsletter.rb")
    end

    def rake_db
      rake("refinery_newsletter:install:migrations")
      rake("refinery_settings:install:migrations")
    end

    def append_load_seed_data
      create_file 'db/seeds.rb' unless File.exists?(File.join(destination_root, 'db', 'seeds.rb'))
      append_file 'db/seeds.rb', :verbose => true do
        <<-EOH

# Added by Refinery CMS Newsletter engine
Refinery::Newsletter::Engine.load_seed
        EOH
      end
    end

  end
end
