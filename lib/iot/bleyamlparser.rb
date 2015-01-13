require "yaml"

Yaml_path = "ble.yml"

module Iot
  module BleYamlParser

    def load_deviceinfo
      # TODO
    end

    def load_yaml_body
      yaml_path = File.expand_path Yaml_path

      if File.exist? yaml_path
        yaml_body = File.read yaml_path
        return YAML.load yaml_body
      else
        return ""
      end
    end

    def refresh_yaml_body yaml
      yaml_path = File.expand_path Yaml_path
      File.open(yaml_path, "w") do |file|
        file = nil
      end
      new_yaml= YAML.dump yaml
      File.write(yaml_path, new_yaml)
    end

    def service_exist?(services, service_name)
      services.each do |service|
        if service["name"] == service_name
          return true
        end
      end

      return false
    end

  end
end
