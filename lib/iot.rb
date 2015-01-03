require "iot/version"
require "iot/help"

module Iot
  extend Iot::Help
  
  def showUsage commands
    puts "usage:"
    commands.each do |cmd|
      puts "   #{cmd[0]}\t#{cmd[1]}"
    end
  end

end
