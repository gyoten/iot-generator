IOT_HELP = <<-EOS
Example usage:
  iot install
  iot uninstall
  iot new app_path
  iot generate

Troubleshooting:
  iot doctor
  iot version
EOS

module Iot
  module Help
    def help
      puts IOT_HELP
    end
  end
end

# NOTE Keep the lenth of vanilla --help less than 25 lines!
# This is because the default Terminal height is 25 lines. Scrolling sucks
# and concision is important. If more help is needed we should start
# specialising help like the gem command does.
# NOTE Keep lines less than 80 characters! Wrapping is just not cricket.
# NOTE The reason the string is at the top is so 25 lines is easy to measure!
