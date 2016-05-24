require "formalist/element"
require "formalist/elements"
require "formalist/types"

module Formalist
  class Elements
    class MultiUploadField < Field
      attribute :presign_url, Types::String
      attribute :render_uploaded_as, Types::String
      attribute :upload_label, Types::String
      attribute :button_label, Types::String
    end

    register :multi_upload_field, MultiUploadField
  end
end
