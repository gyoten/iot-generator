# -*- coding: utf-8 -*-
require "yaml"
require "securerandom"
require "iot/bleyamlparser"
require "pp"

module Iot
  extend BleYamlParser
  module Generate
    def generate(generate_type, name)
      if generate_type.empty?
        puts "Select type \"service\" or \"char\""
        return
      end

      if name.empty?
        puts "Select service / char name"
        return
      end

      if generate_type == "service"
        generate_service name
      elsif generate_type == "char"
        generate_char name
      else
        puts "Select type \"service\" or \"char\""
      end
    end

    def generate_char char_name
      yaml = load_yaml_body
      if yaml.empty?
        puts "No Yaml file"
        return
      end

      deviceinfo = yaml["deviceinfo"]
      services = deviceinfo["services"]

      puts "#{deviceinfo["name"]} has bellow services."
      service_num = 0
      services.each do |service|
        puts "[#{service_num += 1}]\t#{service["uuid"]}\t#{service["name"]}"
      end

      # Choose target service
      while true do
        puts ""
        puts "Choose an index of target service"
        print "> "
        service_index = STDIN.gets
        service_index = service_index.chomp.to_i

        if service_index > 0 && service_index <= service_num
          break
        end

        puts "#{service_index} is invalid index number"
      end

      # select property of gatt characteristic
      properties = []
      ["read", "write", "notify"].each do |property|
        while true do
          puts ""
          puts "Add \"#{property}\" property?(Type y / n)"
          print "> "

          selection = STDIN.gets.chomp
          if selection == "y"
            properties << property
            break
          elsif selection == "n"
            break
          else
            puts "Type \"y\" or \"n\""
          end
        end
      end

      # Add new characteristic
      target_service = services[service_index - 1]
      new_char = {
        "name" => char_name,
        "uuid" => SecureRandom.uuid,
        "payload" => 0,
        "properties" => properties
      }
      chars = target_service["chars"]
      if chars == nil
        chars = []
      end
      chars << new_char

      # Rewrite the yaml file
      target_service["chars"] = chars
      refresh_yaml_body yaml
      pp yaml
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
      unless services == nil
        if service_exist?(services, service_name)
          puts "#{service_name} already exist"
          return
        end
      end

      # サービスを追加
      new_service = {
        "name" => service_name,
        "uuid" => SecureRandom.uuid,
        "chars" => nil
      }
      if services == nil
        deviceinfo["services"] = []
        services = deviceinfo["services"]
      end
      services << new_service

      # YAMLファイルの内容をサービスを追加したものに変更
      refresh_yaml_body yaml
      pp yaml
    end

  end
end
