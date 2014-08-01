require "spec_helper"

describe Magnitude::Unit do
  context "inialization" do
    it "has type reader" do
      unit = described_class.new(type: :foo)
      expect(unit.type).to eq(:foo)
    end

    it "has name reader" do
      unit = described_class.new(name: "Foo")
      expect(unit.name).to eq("Foo")
    end

    it "has abbreviation reader" do
      unit = described_class.new(abbr: "F")
      expect(unit.abbr).to eq("F")
    end

    it "has plural reader" do
      unit = described_class.new(plural: "feet")
      expect(unit.plural).to eq("feet")
    end

    it "pluralizes name if no plural was provided" do
      unit = described_class.new(name: "meter")
      expect(unit.plural).to eq("meters")
    end
  end

  context "convertion" do
    it "uses flat ratio" do
      unit = described_class.new(ratio: 0.3048)

      expect(unit.to_base_value(100)).to eq(30.48)
      expect(unit.from_base_value(30.48)).to eq(100.0)
    end

    it "can use custom convertion" do
      unit = described_class.new(
        to_base_value: ->(value){ (value + 459.67) * Rational(5, 9) },
        from_base_value: ->(base){ base * Rational(9, 5) - 459.67 }
      )

      expect(unit.to_base_value(-459.67)).to eq(0.0)
      expect(unit.from_base_value(0)).to eq(-459.67)
    end
  end
end
