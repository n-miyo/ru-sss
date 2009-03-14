require 'rubygems'
require 'UPnP/control/device'
require 'UPnP/control/service/disk_stat'

class UPnP::Control::Device::SystemStatServer < UPnP::Control::Device

  VERSION = '1.0.0'

  URN_1 = [UPnP::DEVICE_SCHEMA_PREFIX, name.split(':').last, 1].join ':'

  def print_free_size(path = '/', unit = 'm')
    puts "server: #{friendly_name || presentation_url}"
    size = ds.GetDiskFreeSpace path, unit
    puts "free size: #{size} #{unit.upcase} bytes."
  end

  def disk_stat
    @ds ||= services.find do |service|
      service.type == UPnP::Control::Service::DiskStat::URN_1
    end

    @ds
  end

  alias ds disk_stat

end
