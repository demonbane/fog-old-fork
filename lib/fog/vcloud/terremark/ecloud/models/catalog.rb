module Fog
  module Vcloud
    module Terremark
      module Ecloud

        class Catalog < Fog::Vcloud::Collection

          model Fog::Vcloud::Terremark::Ecloud::CatalogItem

          attribute :href, :aliases => :Href

          def all
            if data = connection.get_catalog(href).body[:CatalogItems][:CatalogItem]
              load(data)
            end
          end

          def get(uri)
            if data = connection.get_catalog_item(uri)
              new(data.body)
            end
          rescue Fog::Errors::NotFound
            nil
          end

        end
      end
    end
  end
end
