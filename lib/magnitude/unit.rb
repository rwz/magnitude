module Magnitude
  class Unit
    def initialize(options)
      @options = options
    end

    def to_base_value(value)
      to_base_value_proc.call(value)
    end

    def from_base_value(base)
      from_base_value_proc.call(base)
    end

    def type
      require_option(:type)
    end

    def name
      require_option(:name)
    end

    def abbr
      require_option(:abbr)
    end

    def plural
      require_option(:plural){ "#{name}s" }
    end

    private

    def to_base_value_proc
      @to_base_value_proc ||= require_option(:to_base_value) do
        ratio = require_option(:ratio, 1)
        ->(value){ value * ratio }
      end
    end

    def from_base_value_proc
      @from_base_value_proc ||= require_option(:from_base_value) do
        ratio = require_option(:ratio, 1)
        ->(base){ Rational(base, ratio) }
      end
    end

    def require_option(key, *args, &block)
      @options.fetch(key, *args, &block)
    rescue KeyError => e
      fail ArgumentError, "missing required argument: #{key}"
    end
  end
end
