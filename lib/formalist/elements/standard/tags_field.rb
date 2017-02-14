require "formalist/element"
require "formalist/elements"
require "formalist/types"

module Formalist
  class Elements
    class TagsField < Field
      attribute :search_url, Types::String
      attribute :search_per_page, Types::Int
      attribute :search_params, Types::Hash
      attribute :search_threshold, Types::Int
    end

    register :tags_field, TagsField
  end
end
