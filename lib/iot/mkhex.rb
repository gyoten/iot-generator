module Iot
  module Mkhex
    def mkhex(softdevicehex_path, projecthex_path)
      str = File.read softdevicehex_path
      str.gsub!(":00000001FF", "")
      str.chomp!

      str << "\n"
      str << File.read(projecthex_path)

      File.write("combined.hex", str)
    end
  end
end
