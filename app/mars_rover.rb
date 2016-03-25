

# Each rover receives a hash of instructions
# hash = {coords_x: int, coords_y: int, orientation: string, sequence: string}
# Rovers can turn in place (left or right) and move forward.
class Rover
  attr_reader :coords_x, :coords_y, :orientation, :sequence

  def initialize(rover_input)
    @coords_x = rover_input[:coords_x]
    @coords_y = rover_input[:coords_y]
    @orientation = rover_input[:orientation]
    @sequence = rover_input[:sequence]
  end

  # Expected commands are L, R or M.
  def perform_sequence
    @sequence.each_char do |chr|
      case chr
      when 'L' then turn_left
      when 'R' then turn_right
      when 'M' then move_forward
      end
    end
  end

  private

  def turn_left
    case @orientation
    when 'N' then @orientation = 'W'
    when 'S' then @orientation = 'E'
    when 'E' then @orientation = 'N'
    when 'W' then @orientation = 'S'
    end
  end

  def turn_right
    case @orientation
    when 'N' then @orientation = 'E'
    when 'S' then @orientation = 'W'
    when 'E' then @orientation = 'S'
    when 'W' then @orientation = 'N'
    end
  end

  def move_forward
    case @orientation
    when 'N' then @coords_y += 1
    when 'S' then @coords_y -= 1
    when 'E' then @coords_x += 1
    when 'W' then @coords_x -= 1
    end
  end
end
