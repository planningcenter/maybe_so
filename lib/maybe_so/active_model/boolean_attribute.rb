module MaybeSo
  module ActiveModel
    module BooleanAttribute
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def boolean_attribute(attribute, options = {})
          truthy_values = options.delete(:truthy_values) || MaybeSo::DEFAULT_TRUTHY_VALUES
          skip_validator = options.delete(:skip_validator)

          # Override the attribute's ActiveModel or ActiveRecord setter to always set a boolean
          #
          # Example:
          # def hidden=(hidden)
          #   ...
          # end
          define_method "#{attribute}=" do |value|
            boolean = truthy_values.include? value.to_s.downcase
            if respond_to? :[]= # Use ActiveRecord setter
              self[attribute.to_sym] = boolean
            else
              instance_variable_set("@#{attribute}", boolean)
            end
          end

          # Add a validator that ensures only `true` or `false` are ever written to
          # the database, regardless of whether or not the setter above was used for
          # assignment.
          unless skip_validator
            instance_eval do
              validates_inclusion_of attribute.to_sym, in: [true, false], allow_blank: true
            end
          end
        end
      end
    end
  end
end
