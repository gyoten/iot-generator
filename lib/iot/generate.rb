# -*- coding: utf-8 -*-
require "open3"
require "yaml"
require "securerandom"

module Iot
  module Generate
    def generate(generate_type, service_name)
      if generate_type.empty?
        puts "Select type"
        return
      end

      if service_name.empty?
        puts "Select service name"
        return
      end

      generate_service service_name
    end

    def generate_service service_name
      yaml_path = File.expand_path "ble.yml"

      if File.exist? yaml_path
        yaml_body = File.read yaml_path
        yaml = YAML.load yaml_body
      else
        puts "No such file #{yaml_path}"
        return
      end

      deviceinfo = yaml["deviceinfo"]
      services = deviceinfo["services"]

      # サービスの名前が重複していないかを確認
      if service_exist?(services, service_name)
        puts "#{service_name} already exist"
        return
      end

      # サービスを追加
      new_service = {
        "name" => service_name,
        "uuid" => SecureRandom.uuid,
        "chars" => []
      }
      services << new_service

      # YAMLファイルの内容をサービスを追加したものに変更
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
