require "iot/version"
require "iot/help"
require "iot/install"
require "iot/new"

module Iot
  extend Iot::Help
  extend Iot::Install
  extend Iot::New

  def showUsage commands
    puts "usage:"
    commands.each do |cmd|
      puts "   #{cmd[0]}\t#{cmd[1]}"
    end
  end

end
