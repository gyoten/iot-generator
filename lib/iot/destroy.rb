# -*- coding: utf-8 -*-
require "pp"

module Iot
  module Destroy

    def destroy(destroy_type, service_name)
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
