require "FileUtils"
require "open3"

# Template files
require "iot/new/main"
require "iot/new/makefile"
require "iot/new/stservice"
require "iot/new/stbledevice"
require "iot/new/stdeviceinfo"

Iot_dir = "iot"

module Iot
  module New
    def new project_path

      if project_path.empty?
        puts "No value provided for required arguments 'app_path'"
        return
      end

      if File.exist? project_path
        puts "#{project_path already exists}"
        return
      end

      project_path = File.expand_path project_path


      Dir.mkdir project_path
      Dir.mkdir "#{project_path}/#{Iot_dir}"

      init_files = [
        "Makefile",
        "main.cpp",
        "#{Iot_dir}/STService.h",
        "#{Iot_dir}/STBLEdevice.h",
        "#{Iot_dir}/STDeviceInfo.h"
      ]

      template_files = [
        Template_makefile,
        Template_main,
        Template_stservice,
        Template_stbledevice,
        Template_stdeviceinfo
      ]

      count = 0
      init_files.each do |init_file|
        File.open("#{project_path}/#{init_file}", "w") do |file|
          file.puts template_files[count]
          count += 1
        end
      end

    end
  end
end
