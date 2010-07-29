module Fog
  module AWS
    module S3
      class Real

        require 'fog/aws/parsers/s3/get_bucket_versioning'

        # Get versioning status for an S3 bucket
        #
        # ==== Parameters
        # * bucket_name<~String> - name of bucket to get versioning status for
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'VersioningConfiguration'<~Hash>
        #         * Status<~String>: Versioning status in ['Enabled', 'Suspended', nil]
        #
        def get_bucket_versioning(bucket_name)
          unless bucket_name
            raise ArgumentError.new('bucket_name is required')
          end
          request({
            :expects    => 200,
            :headers    => {},
            :host       => "#{bucket_name}.#{@host}",
            :idempotent => true,
            :method     => 'GET',
            :parser     => Fog::Parsers::AWS::S3::GetBucketVersioning.new,
            :query      => {'versioning' => nil}
          })
        end

      end

      class Mock

        def get_bucket_versioning(bucket_name)
          Fog::Mock.not_implemented
        end

      end
    end
  end
end
