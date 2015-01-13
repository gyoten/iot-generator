require "yaml"
require "iot/bleyamlparser"

module Iot
  module Service

    def service
      yaml = load_yaml_body

      deviceinfo = yaml["deviceinfo"]
      services = deviceinfo["services"]

      services.each do |service|
        char_count = service["chars"].count
        puts "#{service["uuid"]}\t#{service["name"]}: has #{char_count} characteristics"
      end
    end

  end
end
