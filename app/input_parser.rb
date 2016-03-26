

class InputParser
  attr_reader :plateau_dimensions, :rover_input
  attr_accessor :filename

  def initialize(filename)
    @filename = filename
  end

  def parse_file
    validate_input
    @instructions = File.readlines(@filename)
    @plateau_dimensions = extract_plateau_input
    extract_rover_input
  end

  def validate_input
    raise 'Invalid filename, or file does not exist' unless valid_filename?
    raise 'Invalid or missing plateau dimensions' unless valid_dimensions?
  end

  def valid_filename?
    @filename.is_a?(String) && File.exist?(@filename)
  end

  def valid_dimensions?
    file_content = File.open(@filename).gets
    plateau_dimensions = file_content.lines.first
    plateau_dimensions =~ /(^[\d]+\s[\d]+\n)/
  end

  private

  # Basic check that instruction line matches requirements
  # Regex match is checking for [integer] [space] [integer]
  def extract_plateau_input
    first_line = @instructions.shift
    if first_line =~ /(^[\d]+\s[\d]+)/
      plateau_dimensions = first_line.split(/\s/)
      plateau_dimensions.map!(&:to_i)
    end
  end

  # Slices the first and second lines from the instructions.
  # Mutates @instructions: the method completes when @instructions is emptied.
  # Parses the extracted lines to meet the requirements for rover parameters.
  def extract_rover_input
    @rover_input = []
    while @instructions.length >= 2
      rover_input = @instructions.shift(2)
      unless rover_input.nil?
        position = rover_input[0].split(/\s/)
        sequence = rover_input[1].chomp
        coords_x = position[0].to_i
        coords_y = position[1].to_i
        orientation = position[2]
        @rover_input.push(package_rover_input(
                            coords_x, coords_y, orientation, sequence))
      end
    end
  end

  # Creates a hash containing initial position and movement sequence.
  # Adds each hash to the rover_missions array.
  def package_rover_input(coords_x, coords_y, orientation, sequence)
    { coords_x: coords_x, coords_y: coords_y, orientation: orientation,
      sequence: sequence }
  end
end
