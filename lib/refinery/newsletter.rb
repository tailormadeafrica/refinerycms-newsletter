require 'refinerycms-core'
require 'refinerycms-settings'
require 'filters_spam'
require 'rails_autolink'

module Refinery
  autoload :NewsletterGenerator, 'generators/refinery/newsletter/newsletter_generator'

  module Newsletter
    require 'refinery/newsletter/engine'
    require 'refinery/newsletter/configuration'

    autoload :Version, 'refinery/newsletter/version'
    autoload :Tab, 'refinery/newsletter/tabs'

    class << self
      attr_writer :root
      attr_writer :tabs

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def tabs
        @tabs ||= []
      end

      def version
        ::Refinery::Newsletter::Version.to_s
      end

      def factory_paths
        @factory_paths ||= [ root.join("spec/factories").to_s ]
      end
    end
  end
end
