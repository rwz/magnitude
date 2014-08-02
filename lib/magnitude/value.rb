module Magnitude
  class Value
    def initialize(magnitude, unit)
      @magnitude, @unit = magnitude, unit
      freeze
    end
  end
end
