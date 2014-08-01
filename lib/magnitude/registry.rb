module Magnitude
  class Registry
    def initialize
      @flat_list = {}
      @types = {}
    end

    def register(type, options)
      unit = Unit.new(options.merge(type: type))
      register_keys unit, @flat_list
      @types[type] ||= {}
      register_keys unit, @types[type]
      unit
    end

    def fetch(key, options={})
      if options.key?(:type)
        type = options.fetch(:type)
        fail UnknownTypeError, "unknown type: #{type}" unless @types.key?(type)
        fetch_unit(key, @types[type])
      else
        fetch_unit(key, @flat_list)
      end
    end

    private

    def register_keys(unit, hash)
      unit_keys(unit).each do |key|
        register_key unit, hash, key
      end
    end

    def register_key(unit, hash, key)
      hash[key] ||= []
      hash[key] << unit
    end

    def unit_keys(unit)
      [
        unit.abbr,
        unit.name,
        unit.plural,
        unit.name.downcase,
        unit.plural.downcase
      ].map(&:to_s).uniq
    end

    def fetch_unit(key, hash)
      key = key.to_s
      fail UnknownUnitError, "unknown unit: #{key}" unless hash.key?(key)
      units = hash.fetch(key)
      return units.first if units.one?
      possible_types = units.map(&:type).join(", ")
      fail AmbiguousUnitError, "ambiguous unit: #{key}. Possible types: #{possible_types}"
    end
  end
end
