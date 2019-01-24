module Refinery
  module Newsletter
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery::Newsletter

      initializer "register refinerycms_newsletter plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = "refinerycms_newsletter"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.newsletter_admin_posts_path }
          plugin.menu_match = /refinery\/newsletter\/?(posts|comments|categories)?/
          plugin.activity = { :class_name => :'refinery/newsletter/post' }
        end
      end

      config.after_initialize do
        Refinery.register_engine(Refinery::Newsletter)
      end
    end
  end
end
