Shindo.tests('Linode | linodeplans requests', ['linode']) do

  @linodeplans_format = Linode::Formats::BASIC.merge({
    'DATA' => [{ 
      'AVAIL' => {
         '2' => Integer,
         '3' => Integer,
         '4' => Integer,
         '6' => Integer,
         '7' => Integer
      },
      'DISK'    => Integer,
      'PLANID'  => Integer,
      'PRICE'   => Float,
      'RAM'     => Integer,
      'LABEL'   => String,
      'XFER'    => Integer
    }]
  })

  tests('success') do

    @linodeplan_id = nil

    tests('#avail_linodeplans').formats(@linodeplans_format) do
      data = Linode[:linode].avail_linodeplans.body
      @linodeplan_id = data['DATA'].first['PLANID']
      data
    end

    tests("#avail_linodeplans(#{@linodeplan_id})").formats(@linodeplans_format) do
      Linode[:linode].avail_linodeplans(@linodeplan_id).body
    end

  end

end
