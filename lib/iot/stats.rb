require "yaml"
require "iot/bleyamlparser"

module Iot
  module Stats
    def stats
      puts YAML.dump load_yaml_body
    end
  end
end
