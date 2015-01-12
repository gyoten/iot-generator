# -*- coding: utf-8 -*-
require "yaml"
require "securerandom"
require "iot/bleyamlparser"
require "pp"

module Iot
  extend BleYamlParser
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
      yaml = load_yaml_body
      if yaml.empty?
        puts "No Yaml file"
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
      refresh_yaml_body yaml
      pp yaml
    end

  end
end
