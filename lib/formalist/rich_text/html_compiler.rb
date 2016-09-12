require "formalist/rich_text/html_renderer"

module Formalist
  module RichText
    class HTMLCompiler
      LIST_ITEM_TYPES = %w(unordered-list-item ordered-list-item)

      attr_reader :renderer

      def initialize(renderer = nil)
        @renderer = renderer || HTMLRenderer.new
      end

      def call(ast)
        renderer.nodes(wrap_lists(ast)) do |node|
          visit(node)
        end
      end

      private

      def visit(node)
        type, content = node

        send(:"visit_#{type}", content)
      end

      def visit_block(data)
        type, key, children = data

        renderer.block(type, key, wrap_lists(children)) do |child|
          visit(child)
        end
      end

      def visit_wrapper(data)
        type, children = data

        renderer.wrapper(type, children) do |child|
          visit(child)
        end
      end

      def visit_inline(data)
        styles, text = data

        renderer.inline(styles, text)
      end

      def visit_entity(data)
        type, key, _mutability, data, children = data

        renderer.entity(type, key, data, wrap_lists(children)) do |child|
          visit(child)
        end
      end

      def wrap_lists(nodes)
        chunked = nodes.chunk do |node|
          type, content = node

          if type == "block"
            content[0] # return the block's own type
          else
            type
          end
        end

        chunked.inject([]) { |output, (type, chunk)|
          if list_item?(type)
            output << convert_to_wrapper_node(type, chunk)
          else
            # Flatten again by appending chunk onto array
            output + chunk
          end
        }
      end

      def convert_to_wrapper_node(type, children)
        ["wrapper", [type, children]]
      end

      def list_item?(type)
        LIST_ITEM_TYPES.include?(type)
      end
    end
  end
end
