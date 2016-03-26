
# This file is called main.rb
# It takes the contents of game_input.txt and sends it to the Mars Base.
# Mars Base is awesome, it will parse your instructions, map the plateau
# and communicate your commands to the rovers.
#
# Try editing the command sequences for the rovers in game_input.txt
# Please keep Mars Base happy by following the input conventions.
# Run this file from the command line, see where each rover travels to!

require_relative 'mission_control'

filename = 'game_input.txt'

mission = MissionControl.new(ARGV[0] || filename)

puts 'OUTPUT:'
mission.run
puts mission.rover_report
