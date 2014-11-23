require 'artoo'

class Joystick < Artoo::Robot
  connection :joystick, :adaptor => :joystick
  device :joystick, :driver => :joystick, :connection => :joystick, :interval => 0.1

  work do
    on joystick, :joystick => proc { |caller, value|
      puts 'joystick ' + value[:s].to_s, value[:x], value[:y]
    }
    on joystick, :button => proc { |*value|
      puts 'button ' + value[1]
    }
  end
end

Joystick.new.work
