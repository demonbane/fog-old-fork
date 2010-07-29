require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/../../shared_examples/servers_examples'

describe 'Fog::Bluebox::Servers' do

  it_should_behave_like "Servers"

  # flavor 1 = 256, image 3 = gentoo 2008.0
  subject {
    @flavor_id  = '94fd37a7-2606-47f7-84d5-9000deda52ae' # Block 1GB Virtual Server
    @image_id   = 'a00baa8f-b5d0-4815-8238-b471c4c4bf72' # Ubuntu 9.10 64bit
    @server = @servers.new(:flavor_id => @flavor_id, :image_id => @image_id, :password => "chunkybacon")
    @server
  }

  before(:each) do
    @servers = Bluebox[:blocks].servers
  end

  after(:each) do
    if @server && !@server.new_record?
      @server.wait_for { ready? }
      @server.destroy.should be_true
    end
  end

end
