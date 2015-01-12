require "iot/version"
require "iot/help"
require "iot/install"
require "iot/new"
require "iot/run"
require "iot/generate"
require "iot/destroy"
require "iot/stats"

module Iot
  extend Iot::Help
  extend Iot::Install
  extend Iot::New
  extend Iot::Run
  extend Iot::Generate
  extend Iot::Destroy
  extend Iot::Stats

  def showUsage commands
    puts "usage:"
    commands.each do |cmd|
      puts "   #{cmd[0]}\t#{cmd[1]}"
    end
  end

end
