require 'rubygems'
require 'UPnP/control/service'

class UPnP::Control::Service::DiskStat < UPnP::Control::Service

  URN_1 = [UPnP::SERVICE_SCHEMA_PREFIX, name.split(':').last, 1].join ':'

end

