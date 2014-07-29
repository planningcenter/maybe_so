require "spec_helper"

describe MaybeSo::ActiveModel::BooleanAttribute do
  before do
    @klass = Class.new
    @klass.send(:include, ActiveModel::Model)
  end

  it "has the #boolean_attribute method on the class" do
    expect(@klass).to respond_to(:boolean_attribute)
  end

  describe "#boolean_attribute" do
    describe "attribute setter override" do
      it "overrides the setter" do
        @klass.boolean_attribute :hidden
        expect(@klass.instance_methods).to include(:hidden=)
      end

      it "adds the attribute validator" do
        @klass.boolean_attribute :hidden
        expect(@klass.validators.map(&:attributes).flatten).to include(:hidden)
      end

      it "skips the validator if arg is provided" do
        @klass.boolean_attribute :hidden, skip_validator: true
        expect(@klass.validators.map(&:attributes).flatten).to_not include(:hidden)
      end
    end

    context "when a boolean attribute is defined" do
      before do
        @klass.send(:attr_reader, :hidden)
        @klass.boolean_attribute :hidden
        @record = @klass.new
      end

      it "accepts truthy values and reads them as booleans" do
        @record.hidden = "T"
        expect(@record.hidden).to eq(true)

        @record.hidden = "Yes"
        expect(@record.hidden).to eq(true)
      end

      it "accepts falsy values and reads them as booleans" do
        @record.hidden = "F"
        expect(@record.hidden).to eq(false)

        @record.hidden = "No"
        expect(@record.hidden).to eq(false)
      end

      it "coerces nil to false" do
        @record.hidden = nil
        expect(@record.hidden).to eq(false)
      end

    end
  end
end
