module Fog
  module Vcloud
    module Terremark
      module Ecloud
        class CatalogItem < Fog::Vcloud::Model

          identity :href, :Href

          ignore_attributes :xmlns, :xmlns_i, :xmlns_xsi, :xmlns_xsd

          attribute :type
          attribute :name
          attribute :entity, :aliases => :Entity
          attribute :link, :aliases => :Link
          attribute :property, :aliases => :Property

          def customization_options
            load_unless_loaded!
            if data = connection.get_customization_options( link[:href] ).body
              data.delete_if { |key, value| [:xmlns_i, :xmlns].include?(key) }
              data
            else
              nil
            end
          end

        end
      end
    end
  end
end
