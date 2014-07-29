require "spec_helper"

describe String do
  describe "#to_bool" do
    MaybeSo::DEFAULT_TRUTHY_VALUES.each do |truth|
      context "when #{truth}" do
        it "returns true" do
          expect(truth.to_bool).to eq(true)
        end
      end
    end

    context "when any other string value" do
      it "returns false" do
        expect("foooo".to_bool).to eq(false)
      end
    end
  end
end
