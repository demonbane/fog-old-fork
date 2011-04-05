class DNSimple < Fog::Bin
  class << self

    def class_for(key)
      case key
      when :dns
        Fog::DNSimple::DNS
      else
        raise ArgumentError, "Unrecognized service: #{key}"
      end
    end

    def [](service)
      @@connections ||= Hash.new do |hash, key|
        hash[key] = case key
                    when :dns
                      Fog::DNS.new(:provider => 'DNSimple')
                    else
                      raise ArgumentError, "Unrecognized service: #{key.inspect}"
                    end
      end
      @@connections[service]
    end

    def services
      Fog::DNSimple.services
    end

  end
end
