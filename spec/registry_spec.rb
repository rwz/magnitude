require "magnitude"

describe Magnitude::Registry do
  context "#register" do
    it "registers a unit and returns an instance" do
      result = subject.register(:length, name: "meter", abbr: :m)
      expect(result).to be_kind_of(Magnitude::Unit)
      expect(result.name).to eq("meter")
    end
  end

  context "#fetch" do
    before{ subject.register :mass, name: "Pound", abbr: :lb }

    it "finds unit by abbreviation" do
      result = subject.fetch(:lb)
      expect(result).to be_kind_of(Magnitude::Unit)
      expect(result.name).to eq("Pound")
    end

    it "finds unit by name" do
      result = subject.fetch("Pound")
      expect(result).to be_kind_of(Magnitude::Unit)
      expect(result.name).to eq("Pound")
    end

    it "finds unit by plural name" do
      result = subject.fetch("Pounds")
      expect(result).to be_kind_of(Magnitude::Unit)
      expect(result.name).to eq("Pound")
    end

    it "finds unit by lower cased name" do
      result = subject.fetch("pound")
      expect(result).to be_kind_of(Magnitude::Unit)
      expect(result.name).to eq("Pound")
    end

    it "finds unit by lower cased name" do
      result = subject.fetch("pounds")
      expect(result).to be_kind_of(Magnitude::Unit)
      expect(result.name).to eq("Pound")
    end

    it "raises unknown unit error" do
      action = ->{ subject.fetch(:foo) }
      expect(&action).to raise_error(Magnitude::UnknownUnitError, "unknown unit: foo")
    end

    it "raises unknown type error" do
      action = ->{ subject.fetch(:foo, type: :bar) }
      expect(&action).to raise_error(Magnitude::UnknownTypeError, "unknown type: bar")
    end

    context "ambiguous unit" do
      before{ subject.register :force, name: "Pound", abbr: :lb }

      it "raises ambiguous error" do
        action = ->{ subject.fetch(:lb) }
        expect(&action).to raise_error(Magnitude::AmbiguousUnitError, "ambiguous unit: lb. Possible types: mass, force")
      end
    end
  end
end
