# MARS ROVER PROJECT

You know the drill:

NASA is sending a squad of robotic rovers to Mars and will be landing them on a plateau. The plateau conveniently happens to be perfectly rectangular. For undisclosed reasons, NASA wants the rovers to move around the plateau.

The location and orientation of each rover is represented by a combination of x and y co-ordinates and a letter representing one of the four compass points (N, S, E, W). The plateau is divided up into a grid to simplify navigation. An example position might be 0, 0, N, which means the rover is in the bottom left corner and facing North.

These rovers are basic but durable. They can turn on the spot but can only move forward.

In order to direct the movements of a rover, NASA sends a simple string of letters. The possible letters are ‘L’, ‘R’ and ‘M’. ‘L’ and ‘R’ makes the rover spin 90 degrees left or right respectively, without moving from its current spot. ‘M’ means move forward one grid point, and maintain the same heading.

------------------------
#### REQUIREMENTS

Built and tested with:
- Ruby version 2.3.0
- RSpec version 3.4.3
- Rbenv version 1.0.0

#### GETTING STARTED

1. Ensure your system has the requirements installed
2. Extract the mars-rover folder from the archive
3. Navigate into the mars-rover directory: `$ cd mars-rover`
4. Install dependencies: `$ bundle install`

#### SEE IT IN ACTION!

Run it from the command line: `$ ruby app/mars_game.rb`
Run it with the contents of a different file by passing the filename as a command line argument: `$ ruby app/mars_game.rb 'custom_input.txt'`

See the comments in mars_game.rb for more information.

#### RUN THE TESTS

- Tests are written with RSpec
- The tests can be run from the mars-rover directory: `$ rspec`

#### CURRENT ASSUMPTIONS:

- The input is transmitted as a .txt file and the contents will be the following format:

5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM

This is equivalent to: "5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM"

- NASA would account for the starting positions of each rover landed on the plateau, and would avoid collision. Rovers can be positioned and moved sequentially:
Rover 1: position -> move -> report location
Rover 2: position -> move -> report location

- NASA has excellent proofreaders and would not transmit defective or malicious instructions. Some limited validation exists; it is not bulletproof.

- The Mars rover project is a small scale operation; there will not be hundreds or thousands of rovers.

- Rovers may fall into fissures, off the plateau, or otherwise die. If a rover moves to a location not on the plateau, it is lost and will not report a final location, instead it will appear as 'LOST' in the report (although Mars Base can retrieve it's final position).
