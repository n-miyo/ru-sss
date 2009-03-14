require 'rubygems'
require 'UPnP/device'
require 'UPnP/service/disk_stat'

class UPnP::Device::SystemStatServer < UPnP::Device

  VERSION = '1.0.0'

  add_service_id UPnP::Service::DiskStat, 'DiskStat'

  def self.option_parser
    super do |option_parser, options|
      options[:name] = Socket.gethostname.split('.', 2).first

      option_parser.banner = <<-EOF
Usage: #{option_parser.program_name} [options]

Starts a SystemStat Server.
      EOF

      option_parser.separator ''

      option_parser.on('-n', '--name=NAME',
                       'Set the SystemStat Server\'s name') do |value|
        options[:name] = value
      end
    end
  end

  def self.run(argv = ARGV)
    super

    device = create 'SystemStatServer', @options[:name] do |s|
      s.manufacturer     = 'Tempus.ORG'
      s.manufacturer_url = 'http://www.tempus.org'

      s.model_description = "Disk Stat version #{s.class::VERSION}"
      s.model_name        = 'Disk Stat'
      s.model_url         = 'http://www.tempus.org/'
      s.model_number      = UPnP::Device::SystemStatServer::VERSION

      s.add_service 'DiskStat'
    end

    device.run
  end

end

