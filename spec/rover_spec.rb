
require_relative '../app/mars_rover'

describe Rover do
  # pass sample input to the rover for unit testing
  let(:rover_input) {{
                      coords_x: 1,
                      coords_y: 2,
                      orientation: 'N',
                      sequence: 'LMLMLMLMM'
                    }}

  it 'can initialize' do
    rover = Rover.new(rover_input)
    expect(rover.coords_x).to eql(1)
    expect(rover.coords_y).to eql(2)
    expect(rover.orientation).to match('N')
    expect(rover.sequence).to match('LMLMLMLMM')
  end

  it 'can move forward' do
    rover = Rover.new({
                        coords_x: 2,
                        coords_y: 2,
                        orientation: 'N',
                        sequence: 'MMM'
                      })
    rover.perform_sequence
    expect(rover.coords_y).to eql(5)
    expect(rover.orientation).to match('N')
  end

  it 'can turn left' do
    rover = Rover.new({
                        coords_x: 2,
                        coords_y: 2,
                        orientation: 'N',
                        sequence: 'LLL'
                      })
    rover.perform_sequence
    expect(rover.orientation).to match('E')
  end

  it 'can turn right' do
    rover = Rover.new({
                        coords_x: 2,
                        coords_y: 2,
                        orientation: 'N',
                        sequence: 'R'
                      })
    rover.perform_sequence
    expect(rover.orientation).to match('E')
  end
end
