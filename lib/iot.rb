require "iot/version"
require "iot/help"
require "iot/install"

module Iot
  extend Iot::Help
  extend Iot::Install
  
  def showUsage commands
    puts "usage:"
    commands.each do |cmd|
      puts "   #{cmd[0]}\t#{cmd[1]}"
    end
  end

end
