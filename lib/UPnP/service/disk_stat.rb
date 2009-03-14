require 'rubygems'
require 'UPnP/service'
require 'sys/filesystem'

class UPnP::Service::DiskStat < UPnP::Service

  VERSION = '1.0'

  add_action 'GetDiskFreeSpace',
    [IN, 'FileSystem', 'A_ARG_TYPE_FileSystem'],
    [IN, 'Unit',       'A_ARG_TYPE_Unit'],

    [OUT, 'FreeSpace', 'A_ARG_TYPE_FreeSpace']

  add_variable 'A_ARG_TYPE_FileSystem', 'string'
  add_variable 'A_ARG_TYPE_Unit', 	'string'
  add_variable 'A_ARG_TYPE_FreeSpace',  'i4'

  def GetDiskFreeSpace(file_system, unit)
    result = 0

    begin
      stat = Sys::Filesystem.stat(file_system)

      s = stat.blocks_available * stat.fragment_size
      case unit
      when 'G', 'g'
        result = s / (1024 * 1024 * 1024)
      when 'M', 'm'
        result = s / (1024 * 1024)
      when 'K', 'k'
        result = s / 1024
      else
        result = s
      end
    rescue
      result = 0
    end

    [nil, result]
  end

end
