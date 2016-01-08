module Formalist
  class DisplayAdapters
    class Select
      def call(field)
        raise ArgumentError, "field type must be string or int" unless %w[string int].include?(field.type)
        raise ArgumentError, "field must have +option_values+ config" unless field.config.keys.include?(:option_values)

        field.to_display_variant("select")
      end
    end
  end
end
