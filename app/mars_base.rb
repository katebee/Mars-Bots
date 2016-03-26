
require_relative 'input_parser'
require_relative 'mars_rover'

# Mars Base is the contact point for NASA; it receives, parses and
# relays instructions for the mission.
# A misson has one Plateau, and 0 to many Rovers.
# When creating a new instance, it expects one parameter; a filename (string).
class MarsBase
  attr_reader :rover_missions, :rovers

  def initialize(filename)
    @input_parser = InputParser.new(filename)
    @rover_missions = []
    @rovers = []
  end

  def run
    @input_parser.parse_file
    @plateau = Plateau.new(@input_parser.plateau_dimensions)
    @rover_missions = @input_parser.rover_input
    command_rovers(@plateau)
  end

  # Use to output the mission result to a view, or the command line.
  # Returns a string with the current location (or fate) of each rover.
  # Information for each rover is separated by a newline.
  def rover_report
    report = ''
    @rovers.each do |rover|
      report << rover.report_location << "\n"
    end
    report
  end

  private

  # Initialise a rover for each set of rover commands.
  # Orders the rover to perform the sequence.
  # Adds each rover to the rovers hash.
  def command_rovers(plateau)
    @rover_missions.each do |rover_input|
      rover = Rover.new(rover_input)
      rover.perform_sequence(plateau)
      @rovers.push(rover)
    end
  end
end
