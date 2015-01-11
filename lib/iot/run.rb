require "open3"

module Iot
  module Run
    def run
      puts "building and flashing program..."
      cmd = "make"
      executeOut, _, _ = *Open3.capture3(cmd)
    end
  end
end
