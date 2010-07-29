module Fog
  module Parsers
    module AWS
      module EC2

        class DescribeImages < Fog::Parsers::Base

          def reset
            @image = { 'productCodes' => [], 'blockDeviceMapping' => nil }
            @response = { 'imagesSet' => [] }
          end

          def start_element(name, attrs = [])
            super
            if name == 'productCodes'
              @in_product_codes = true
            elsif name == 'blockDeviceMapping'
              @in_block_device_mapping = true
              @image['blockDeviceMapping'] = []
             elsif name == 'item' && @in_block_device_mapping
              @image['blockDeviceMapping'] << {}
            end
          end
          
          def end_element(name)
            case name
            when 'architecture',  'imageId', 'imageLocation', 'imageOwnerId', 'imageState', 'imageType', 'kernelId', 'platform', 'ramdiskId', 'rootDeviceType','rootDeviceName'
              @image[name] = @value
            when 'isPublic'
              if @value == 'true'
                @image[name] = true
              else
                @image[name] = false
              end
            when 'item'
              if @in_block_device_mapping
              elsif !@in_product_codes
                @response['imagesSet'] << @image
                @image = { 'productCodes' => [] }
              end
            when 'productCode'
              @image['productCodes'] << @value
            when 'productCodes'
              @in_product_codes = false
            when 'blockDeviceMapping'
              @in_block_device_mapping = false
            when 'requestId'
              @response[name] = @value
            when 'deviceName','virtualName','snapshotId','volumeSize','deleteOnTermination'
              l = @image['blockDeviceMapping'].length
              @image['blockDeviceMapping'][l-1].store(name,@value)
            end
          end

        end

      end
    end
  end
end
