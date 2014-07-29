require "spec_helper"

describe Fixnum do
  describe "#to_bool" do
    context "when 1" do
      it "returns true" do
        expect(1.to_bool).to eq(true)
      end
    end

    context "when 0" do
      it "returns false" do
        expect(0.to_bool).to eq(false)
      end
    end

    context "when some other number" do
      it "returns false" do
        expect(42.to_bool).to eq(false)
      end
    end
  end
end
