
module Iot
  module DeviceName

    def toggle_local_name
      yaml = load_yaml_body
      if yaml.empty?
        puts "No Yaml file"
        return
      end

      deviceinfo = yaml["deviceinfo"]
      deviceinfo["adpacket"]["localname"] = 1 - deviceinfo["adpacket"]["localname"].to_i

      if deviceinfo["adpacket"]["localname"] > 0
        puts "Short name is selected for advertising packet"
      else
        puts "Complete name is selected for advertising packet"
      end

      refresh_yaml_body yaml
    end

    def change_complete_name device_name
      change_name("name", device_name)
    end

    def change_short_name device_name
      change_name("shortname", device_name)
    end

    def change_name(key, device_name)
      yaml = load_yaml_body
      if yaml.empty?
        puts "No Yaml file"
        return
      end

      deviceinfo = yaml["deviceinfo"]
      deviceinfo[key] = device_name

      refresh_yaml_body yaml
    end

  end
end
