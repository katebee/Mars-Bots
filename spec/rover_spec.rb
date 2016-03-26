
require_relative '../app/rover'

describe Rover do
  # pass sample input to the rover for unit testing
  let(:plateau) { Plateau.new([5, 5]) }
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
    expect(rover.sequence).to be == 'LMLMLMLMM'
    expect(rover.alive?).to be true
  end

  it 'can move forward' do
    rover = Rover.new({
                        coords_x: 2,
                        coords_y: 2,
                        orientation: 'N',
                        sequence: 'MMM'
                      })
    rover.perform_sequence(plateau)
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
    rover.perform_sequence(plateau)
    expect(rover.orientation).to match('E')
  end

  it 'can turn right' do
    rover = Rover.new({
                        coords_x: 2,
                        coords_y: 2,
                        orientation: 'N',
                        sequence: 'R'
                      })
    rover.perform_sequence(plateau)
    expect(rover.orientation).to match('E')
  end

  it 'can perform the sequence' do
    rover = Rover.new(rover_input)
    rover.perform_sequence(plateau)
    expect(rover.coords_x).to eql(1)
    expect(rover.coords_y).to eql(3)
    expect(rover.orientation).to match('N')
  end

  context 'invalid instructions in sequence' do
    it 'should ingore invalid instructions' do
      rover = Rover.new({
                          coords_x: 2,
                          coords_y: 2,
                          orientation: 'N',
                          sequence: 'INVALIDCOMMANDS'
                        })
      expect { rover.perform_sequence(plateau) }.not_to raise_error
      expect(rover.coords_x).to eql(0)
      expect(rover.coords_y).to eql(2)
      expect(rover.orientation).to match('W')
    end
  end

  it 'can report location' do
    rover = Rover.new(rover_input)
    expect(rover.report_location).to be == '1 2 N'
    expect(rover.report_location).not_to be == ''
  end

  it 'can become lost' do
    rover = Rover.new({
                        coords_x: 0,
                        coords_y: 0,
                        orientation: 'S',
                        sequence: 'M'
                      })
    rover.perform_sequence(plateau)
    expect(rover.report_location).to be == 'ROVER LOST'
    expect(rover.report_location).not_to be == ''
    expect(rover.alive?).to be false
  end
end

describe Plateau do
  let(:plateau_dimensions) { [5, 7] }

  it 'will receive and store the dimensions' do
    plateau = Plateau.new(plateau_dimensions)
    expect(plateau.max_x).to eq(5)
    expect(plateau.max_y).to eq(7)
  end

  it 'will set the min_x and min_y to zero' do
    plateau = Plateau.new(plateau_dimensions)
    expect(plateau.min_x).to eq(0)
    expect(plateau.min_y).to eq(0)
  end

  it 'can check if a location is safe' do
    plateau = Plateau.new(plateau_dimensions)
    expect(plateau.location_is_safe?(5, 7)).to be true
    expect(plateau.location_is_safe?(5, 11)).to be false
    expect(plateau.location_is_safe?(0, -1)).to be false
  end
end
