require "FileUtils"
require "open3"

StroboPath = File.expand_path "/usr/local/strobo"

ArmGccLink = "https://launchpad.net/gcc-arm-embedded/4.9/4.9-2014-q4-major/+download/gcc-arm-none-eabi-4_9-2014q4-20141203-mac.tar.bz2"
ArmGccTarPath = File.expand_path "#{StroboPath}/#{ File.basename ArmGccLink }"
ArmGccPath = "#{StroboPath}/gcc-arm-none-eabi-4_9-2014q4"

NrfSdkLink = "http://developer.nordicsemi.com/nRF51_SDK/nRF51_SDK_7.1.0_372d17a.zip"
NrfSdkZipPath = File.expand_path "#{StroboPath}/#{File.basename NrfSdkLink}"
NrfSdkPath = "#{StroboPath}/nrf51_sdk"

SoftDeviceLink = ""


# Install packages for offline compile
module Iot
  module Install
    
    def installComponents
      makeStroboDir
      getArmGcc
      getNrf51SDK
    end

    def uninstall
      executeOut, _, _ = *Open3.capture3("rm -rf #{StroboPath}")
      puts "rm -rf #{StroboPath}/*"
    end
    
    # Create strobo directory.
    # Check existing of /usr/local/strobo
    # before creating.
    def makeStroboDir
      if File.exist? StroboPath
        puts "already exist #{StroboPath}"
      else
        puts "create #{StroboPath}"
        Dir.mkdir StroboPath
      end
    end

    # Install Arm-GCC
    # see here: https://launchpad.net/gcc-arm-embedded
    def getArmGcc
      if File.exist? ArmGccPath
        puts "already exist #{ArmGccPath}"
        return
      elsif File.exist? ArmGccTarPath
        `rm #{ArmGccTarPath}`
      end

      cmd = "wget #{ArmGccLink} -P #{StroboPath}"
      puts cmd
      `#{cmd}`

      cmd = "tar zxvf #{ ArmGccTarPath } -C #{StroboPath}"
      puts cmd
      executeOut, _, _ = *Open3.capture3(cmd)
      
      `rm #{ArmGccTarPath}`
    end

    def getNrf51SDK

      if !File.exist? NrfSdkPath
        Dir.mkdir NrfSdkPath
      else
        puts "already exist #{NrfSdkPath}"
        return
      end
      
      cmd = "wget #{NrfSdkLink} -P #{StroboPath}"
      puts cmd
      `#{cmd}`

      cmd = "unzip #{NrfSdkZipPath} -d #{NrfSdkPath}"
      puts cmd
      executeOut, _, _ = *Open3.capture3(cmd)

      `rm #{NrfSdkZipPath}`      
    end

    
  end
end
