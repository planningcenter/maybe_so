require "maybe_so/active_model/boolean_attribute"

module ActiveModel
  module Model
    class << self
      def included_with_boolean_attribute(base)
        included_without_boolean_attribute(base)
        base.class_eval do
          include MaybeSo::ActiveModel::BooleanAttribute
        end
      end
      alias_method_chain :included, :boolean_attribute
    end
  end
end

if defined?(::ActiveRecord)
  ActiveRecord::Base.send(:include, MaybeSo::ActiveModel::BooleanAttribute)
end
