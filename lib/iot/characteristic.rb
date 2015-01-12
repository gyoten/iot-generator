require "yaml"
require "iot/bleyamlparser"

module Iot
  module Characteristic

    def char
      yaml = load_yaml_body

      deviceinfo = yaml["deviceinfo"]
      services = deviceinfo["services"]

      char_count = 0
      services.each do |service|
        puts "#{service["name"]}"

        chars = service["chars"]
        chars.each do |char|
          puts "#{char_count += 1}\t#{char["uuid"]}\t#{char["name"]}"
        end

        puts ""
      end
    end

  end
end
