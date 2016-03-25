
require_relative 'mars_rover'

# Mars Base is the contact point for NASA; it receives, parses and
# relays instructions for the mission.
# A misson has one Plateau, and 0 to many Rovers.
# When creating a new instance, it expects one parameter; a filename (string).
class MarsBase
  attr_reader :instructions, :rover_missions, :rovers
  attr_accessor :filename

  def initialize(filename)
    @filename = filename
    @rover_missions = []
    @rovers = []
  end

  def run
    @instructions = File.readlines(@filename)
    @plateau = Plateau.new(extract_plateau_input(@instructions))
    extract_rover_input until @instructions.length < 2
  end

  # Check that the filename is in the correct format and that the file exists.
  def valid_filename?
    @filename.is_a?(String) && File.exist?(@filename)
  end

  # Check that the first line of the file matches the expected format for the
  # plateau dimensions.
  def valid_dimensions?
    file_content = File.open(@filename).gets
    plateau_dimensions = file_content.lines.first
    plateau_dimensions =~ /(^[\d]+\s[\d]+\n)/
  end

  # Calls all the validation predicate methods, if any return false raise an
  # error with a descriptive message.
  def validate_input
    raise 'Invalid filename, or file does not exist' unless valid_filename?
    raise 'Invalid or missing plateau dimensions' unless valid_dimensions?
  end

  # Basic check that instruction line matches requirements
  # Regex match is checking for [integer] [space] [integer]
  def extract_plateau_input(instructions)
    first_line = instructions.slice!(0)
    if first_line =~ /(^[\d]+\s[\d]+)/
      plateau_dimensions = first_line.split(/\s/)
      plateau_dimensions.map!(&:to_i)
    end
  end

  # Slices the first and second lines from the instructions.
  # Mutates @instructions: the method completes when @instructions is emptied.
  # Parses the extracted lines to meet the requirements for rover parameters.
  def extract_rover_input
    rover_input = @instructions.slice!(0, 2)
    unless rover_input.nil?
      position = rover_input[0].split(/\s/)
      sequence = rover_input[1].chomp
      coords_x = position[0].to_i
      coords_y = position[1].to_i
      orientation = position[2]
      package_rover_input(coords_x, coords_y, orientation, sequence)
    end
  end

  # Creates a hash containing initial position and movement sequence.
  # Adds each hash to the rover_missions array.
  def package_rover_input(coords_x, coords_y, orientation, sequence)
    rover_input = {
      coords_x: coords_x,
      coords_y: coords_y,
      orientation: orientation,
      sequence: sequence
    }
    @rover_missions.push(rover_input)
  end
end
