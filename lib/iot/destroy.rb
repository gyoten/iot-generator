# -*- coding: utf-8 -*-
require "pp"

module Iot
  module Destroy

    def destroy(destroy_type, name)
      if destroy_type == "service"
        destroy_service name
      elsif destroy_type == "characteristic"
        destroy_characteristic name
      end
    end

    def destroy_characteristic char_name
      yaml = load_yaml_body
      if yaml.empty?
        puts "No Yaml file"
        return
      end

      deviceinfo = yaml["deviceinfo"]
      services = deviceinfo["services"]

      services.each do |service|
        chars = service["chars"]

        chars.each do |characteristic|
          if characteristic["name"] == char_name
            chars.delete characteristic
            puts "Destroy characteristic: #{char_name}"

            refresh_yaml_body yaml
            puts yaml
            return
          end
        end
      end

      puts "No such service: #{char_name}"
    end

    def destroy_service service_name
      yaml = load_yaml_body
      if yaml.empty?
        puts "No Yaml file"
        return
      end

      deviceinfo = yaml["deviceinfo"]
      services = deviceinfo["services"]

      services.each do |service|
        if service["name"] == service_name
          services.delete service
          puts "Destory service: #{service_name}"

          # YAMLファイルの内容をサービスを追加したものに変更
          refresh_yaml_body yaml
          puts yaml
          return
        end
      end

      puts "No such service: #{service_name}"
    end

  end
end
