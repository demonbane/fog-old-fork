require File.dirname(__FILE__) + '/../../../spec_helper'

describe 'Rackspace::Files.get_container' do
  describe 'success' do

    before(:each) do
      Rackspace[:files].put_container('container_name')
      Rackspace[:files].put_object('container_name', 'object_name', lorem_file)
    end
    
    after(:each) do
      Rackspace[:files].delete_object('container_name', 'object_name')
      Rackspace[:files].delete_container('container_name')
    end

    it "should return proper attributes" do
      actual = Rackspace[:files].get_container('container_name').body
      actual.first['bytes'].should be_an(Integer)
      actual.first['content_type'].should be_a(String)
      actual.first['hash'].should be_a(String)
      actual.first['last_modified'].should be_a(String)
      actual.first['name'].should be_a(String)
    end

  end
  describe 'failure' do

    it "should raise a NotFound error if the container does not exist" do
      lambda do
        Rackspace[:files].get_container('container_name')
      end.should raise_error(Excon::Errors::NotFound)
    end

  end
end
