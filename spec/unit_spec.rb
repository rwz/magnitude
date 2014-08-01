require "spec_helper"

describe Magnitude::Unit do
  context "inialization" do
    it "raises an error when type is not provided" do
      action = ->{ described_class.new({}) }
      expect(&action).to raise_error(ArgumentError, "missing required argument: type")
    end

    it "raises an error when ratio is not provided" do
      action = ->{ described_class.new(type: :foo) }
      expect(&action).to raise_error(ArgumentError, "missing required argument: ratio")
    end
  end

  context "convertion" do
    it "uses flat ratio" do
      unit = described_class.new(
        type: :length,
        ratio: 0.3048
      )

      expect(unit.to_base_value(100)).to eq(30.48)
      expect(unit.from_base_value(30.48)).to eq(100.0)
    end

    it "can use custom convertion" do
      unit = described_class.new(
        type: :temperature,
        name: "Fahrenheit",
        to_base_value: ->(value){ (value + 459.67) * Rational(5, 9) },
        from_base_value: ->(base){ base * Rational(9, 5) - 459.67 }
      )

      expect(unit.to_base_value(-459.67)).to eq(0.0)
      expect(unit.from_base_value(0)).to eq(-459.67)
    end
  end
end
