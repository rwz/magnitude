module Magnitude
  class Unit
    attr_reader :type

    def initialize(options)
      @type = require_option(options, :type)
      extract_converton_procs options
    end

    def to_base_value(value)
      @to_base_value.call(value)
    end

    def from_base_value(base)
      @from_base_value.call(base)
    end

    private

    def extract_converton_procs(options)
      @to_base_value = options.fetch(:to_base_value) do
        ratio = require_option(options, :ratio)
        ->(value){ value * ratio }
      end

      @from_base_value = options.fetch(:from_base_value) do
        ratio = require_option(options, :ratio)
        ->(base){ Rational(base, ratio) }
      end
    end

    def require_option(options, key)
      options.fetch(key)
    rescue KeyError => e
      fail ArgumentError, "missing required argument: #{key}"
    end
  end
end
