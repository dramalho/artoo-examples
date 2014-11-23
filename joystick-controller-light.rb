require 'artoo'

connection :arduino, adaptor: :firmata, port: '/dev/cu.usbmodem1421'
connection :joystick, :adaptor => :joystick

#connection :firmata, :adaptor => :firmata, :port => '127.0.0.1:8023'
device :board, :driver => :device_info
device :led, :driver => :led, :pin => 13
device :joystick, :driver => :joystick, :connection => :joystick, :interval => 0.1


work do
  puts "Firmware name: #{board.firmware_name}"
  puts "Firmata version: #{board.version}"

  on joystick, :joystick => proc { |caller, value|
    # puts 'joystick ' + value[:s].to_s, value[:x], value[:y]
  }
  on joystick, :button => proc { |*value|
    if value[1] == 0
      puts "Led ON"
      led.on unless led.on?
    elsif value[1] == 2
      puts "Led OFF"
      led.off unless led.off?
    end
  }
end
