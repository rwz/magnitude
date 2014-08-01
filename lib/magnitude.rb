require "magnitude/version"

module Magnitude
  autoload :Unit,               "magnitude/unit"
  autoload :Registry,           "magnitude/registry"
  autoload :UnknownUnitError,   "magnitude/errors/unknown_unit"
  autoload :UnknownTypeError,   "magnitude/errors/unknown_type"
  autoload :AmbiguousUnitError, "magnitude/errors/ambiguous_unit"
end
