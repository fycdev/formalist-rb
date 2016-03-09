require "formalist/element"
require "formalist/types"
require "formalist/validation/value_rules_compiler"
require "formalist/validation/predicate_list_compiler"

module Formalist
  class Elements
    class Field < Element
      permitted_children :none

      # @api private
      attr_reader :name

      attribute :label, Types::String
      attribute :hint, Types::String
      attribute :placeholder, Types::String
      attribute :inline, Types::Bool

      # @api private
      attr_reader :predicates

      # @api private
      def initialize(*args, attributes, children, input, rules, errors)
        super

        @name = Types::ElementName.(args.first)

        rules_compiler = Validation::ValueRulesCompiler.new(name)
        predicates_compiler = Validation::PredicateListCompiler.new

        @input = input[name] if input
        @rules = rules_compiler.(@rules)
        @predicates = predicates_compiler.(@rules)
        @errors = (errors[name] || [])[0].to_a
      end

      # Converts the field into an abstract syntax tree.
      #
      # It takes the following format:
      #
      # ```
      # [:field, [params]]
      # ```
      #
      # With the following parameters:
      #
      # 1. Field name
      # 2. Custom form element type (or `:field` otherwise)
      # 3. Associated form input data
      # 4. Validation rules (if any)
      # 5. Validation error messages (if any)
      # 6. Form element attributes
      #
      # @see Formalist::Element::Attributes#to_ast "Form element attributes" structure
      #
      # @example "email" field
      #   field.to_ast
      #   # => [:field, [
      #     :email,
      #     :field,
      #     "jane@doe.org",
      #     [[:and, [
      #       [:predicate, [:filled?, []]],
      #       [:predicate, [:format?, [/\s+@\s+\.\s+/]]]
      #     ]]],
      #     [],
      #     [:object, []],
      #   ]]
      #
      # @return [Array] the field as an abstract syntax tree.
      def to_ast
        # errors looks like this
        # {:field_name => [["pages is missing", "another error message"], nil]}

        [:field, [
          name,
          type,
          input,
          predicates,
          errors,
          Element::Attributes.new(attributes).to_ast,
        ]]
      end
    end
  end
end
