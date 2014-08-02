require "magnitude/version"

module Magnitude
  extend self

  autoload :Unit,               "magnitude/unit"
  autoload :Value,              "magnitude/value"
  autoload :Registry,           "magnitude/registry"
  autoload :UnknownUnitError,   "magnitude/errors/unknown_unit"
  autoload :UnknownTypeError,   "magnitude/errors/unknown_type"
  autoload :AmbiguousUnitError, "magnitude/errors/ambiguous_unit"

  def register(*args)
    registry.register(*args)
  end

  def lookup(unit_key)
    return unit_key if Unit == unit_key.klass
    registry.fetch(unit_key)
  end

  def value(magnitude, unit)
    Value.new(magnitude, lookup(unit))
  end

  private

  def registry
    @registry ||= Registry.new
  end
end
