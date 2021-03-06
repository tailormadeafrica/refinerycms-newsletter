module Refinery
  module Newsletter
    class Version
      @major = 2
      @minor = 0
      @tiny  = 5

      class << self
        attr_reader :major, :minor, :tiny

        def to_s
          [@major, @minor, @tiny].compact.join('.')
        end
      end
    end
  end
end
