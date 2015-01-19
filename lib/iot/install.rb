require "open3"
require "open-uri"
require "fileutils"

StroboPath = File.expand_path "/usr/local/strobo"

ArmGccLink = "https://launchpad.net/gcc-arm-embedded/4.9/4.9-2014-q4-major/+download/gcc-arm-none-eabi-4_9-2014q4-20141203-mac.tar.bz2"
ArmGccTarPath = File.expand_path "#{StroboPath}/#{ File.basename ArmGccLink }"
ArmGccPath = "#{StroboPath}/gcc-arm-none-eabi-4_9-2014q4"

Mbed_Dev_Url = "http://developer.mbed.org/"
Mbed_Ble_Api_Link = "#{Mbed_Dev_Url}teams/Bluetooth-Low-Energy/code/BLE_API/archive/fb2a891a0d98.zip"
Mbed_Nrf51822_Link = "#{Mbed_Dev_Url}teams/Nordic-Semiconductor/code/nRF51822/archive/17fe69405098.zip"
Mbed_Mbed_Link = "#{Mbed_Dev_Url}users/mbed_official/code/mbed/archive/4fc01daae5a5.zip"


# Install packages for offline compile
module Iot
  module Install

    def uninstall
      executeOut, _, _ = *Open3.capture3("rm -rf #{StroboPath}")
      puts "rm -rf #{StroboPath}/*"
    end

    def installComponents
      make_strobo_dir

      # Install mbed Libraries:
      # mbed, BLE_API, nrf51822
      zip_links = [
        Mbed_Ble_Api_Link,
        Mbed_Nrf51822_Link,
        Mbed_Mbed_Link
      ]
      zip_links.each do |zip_link|
        get_lib_zip zip_link
      end

      get_gcc_arm
    end

    private

    # Create strobo directory.
    # Check existing of /usr/local/strobo before creating
    def make_strobo_dir
      if File.exist? StroboPath
        puts "already exist #{StroboPath}"
      else
        puts "create #{StroboPath}"
        Dir.mkdir StroboPath
      end
    end

    # Install Arm-GCC
    # see here: https://launchpad.net/gcc-arm-embedded
    def get_gcc_arm
      if File.exist? ArmGccPath
        puts "already exist #{ArmGccPath}"
        return
      elsif File.exist? ArmGccTarPath
        `rm #{ArmGccTarPath}`
      end

      puts "installing #{ArmGccLink} ..."
      output_path = "#{StroboPath}/#{File.basename ArmGccLink}"
      get_file(ArmGccLink, output_path)

      cmd = "tar zxvf #{ ArmGccTarPath } -C #{StroboPath}"
      puts cmd
      executeOut, _, _ = *Open3.capture3(cmd)

      `rm #{ArmGccTarPath}`
    end

    def get_lib_zip lib_path
      puts "installing #{lib_path} ..."
      output_path = "#{StroboPath}/#{File.basename lib_path}"
      get_file(lib_path, output_path)

      cmd = []
      cmd << "unzip #{StroboPath}/*.zip -d #{StroboPath}"
      cmd << "rm #{StroboPath}/*.zip"
      cmd << "mv #{StroboPath}/nRF51822* #{StroboPath}/nRF51822"
      cmd << "mv #{StroboPath}/mbed* #{StroboPath}/mbed"
      cmd << "mv #{StroboPath}/BLE_API* #{StroboPath}/BLE_API"
      cmd.each do |temp|
        execute_out, _, _ = *Open3.capture3(temp)
      end
    end

    def get_file(url, file_path)
      open( file_path, "wb") do |save_file|
        open(url, "rb") do |read_file|
          save_file.write(read_file.read)
        end
      end
    end

  end
end
