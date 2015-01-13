# -*- coding: utf-8 -*-
require "open3"
require "iot/bleyamlparser"

module Iot
  module Run
    def run
      generate_template_deviceinfo
      generate_template_service
      generate_ad_packet

      puts "building and flashing program..."
      `make`
    end

    def generate_ad_packet
      yaml = load_yaml_body
      if yaml.empty?
        puts "No Yaml file"
        return
      end

      deviceinfo = yaml["deviceinfo"]
    end

    def generate_template_deviceinfo
      yaml = load_yaml_body
      if yaml.empty?
        puts "No Yaml file"
        return
      end

      deviceinfo = yaml["deviceinfo"]
      complete_name = deviceinfo["name"]
      short_name = deviceinfo["shortname"]
      ad_interval = deviceinfo["adpacket"]["interval"]
      localname_flg = deviceinfo["adpacket"]["localname"]

      str = ""
      str << "#define COMP_NAME \"#{complete_name}\"\n"
      str << "#define SHORT_NAME \"#{short_name}\"\n"
      str << "#define SHORT_FLG #{localname_flg}\n"
      str << "#define AD_INTERVAL #{ad_interval}\n"

      File.write("./iot/STDeviceInfo.h", str)
    end

    def generate_template_service
      yaml = load_yaml_body
      if yaml.empty?
        puts "No Yaml file"
        return
      end

      str = ""
      str << "#ifndef INCLUDED_MBED\n"
      str << "#include \"mbed.h\"\n"
      str << "#endif\n"
      str << "#ifndef INCLUDED_BLEDEVICE\n"
      str << "#include \"BLEDevice.h\"\n"
      str << "#endif\n"

      deviceinfo = yaml["deviceinfo"]
      services = deviceinfo["services"]

      services.each do |service|
        service_name = service["name"]
        chars = service["chars"]

        chars.each do |characteristic|
          char_uuid_str = characteristic["uuid"].gsub("-", "")

          char_uuid = []
          (0..15).each do |num|
            char_uuid << char_uuid_str[num*2..(num*2+1)]
          end

          char_name = characteristic["name"]

          str << "static const uint8_t #{char_name}_uuid[16] = {"

          char_uuid.each do |temp|
            str << "0x#{temp}, "
          end

          str << "};\n"

          str << "uint8_t #{char_name}_value[8] = {0,};\n"

          str << "GattCharacteristic #{char_name}(\n"
          str << "#{char_name}_uuid,\n"
          str << "#{char_name}_value,\n"
          str << "sizeof(#{char_name}_value),\n"
          str << "sizeof(#{char_name}_value),\n"

          gatt_properties = []
          properties = characteristic["properties"]
          if properties.include? "read"
            gatt_properties << "GattCharacteristic::BLE_GATT_CHAR_PROPERTIES_READ"
          end

          if properties.include? "write"
            gatt_properties << "GattCharacteristic::BLE_GATT_CHAR_PROPERTIES_WRITE"
          end

          if properties.include? "notify"
            gatt_properties << "GattCharacteristic::BLE_GATT_CHAR_PROPERTIES_NOTIFY"
          end

          gatt_properties.each do |temp|
            str << "#{temp} |"
          end

          str << ");\n"

          str.gsub!("|)", ")")
        end


        str << "GattCharacteristic *#{service_name}_chars[] = {\n"
        chars.each do |characteristic|
          str << "&#{characteristic["name"]},\n"
        end
        str << "};\n"

        service_uuid_str = service["uuid"].gsub("-", "")
        service_uuid = []
        (0..15).each do |num|
          service_uuid << service_uuid_str[num*2..(num*2+1)]
        end

        service_name = service["name"]
        str << "static const uint8_t #{service_name}_uuid[] = {\n"

        service_uuid.each do |temp|
          str << "0x#{temp}, "
        end
        str << "};\n"

        str << "GattService #{service_name}(\n"
        str << "#{service_name}_uuid,\n"
        str << "#{service_name}_chars,\n"
        str << "sizeof(#{service_name}_chars) / sizeof(GattCharacteristic *)\n"
        str << ");\n"

      end

      str << "GattService *GattServices[]={\n"
      services.each do |service|
        str << "&#{service["name"]},"
      end
      str << "};"


      File.write("./iot/STService.h", str)
    end
  end
end
