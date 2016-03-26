
require_relative '../app/input_parser'

describe InputParser do
  let(:filename) { 'test_input.txt' }
  let(:invalid_filename) { 'does_not_exist.txt' }
  let(:invalid_input) { 'invalid_input.txt' }

  it 'will store the filename as a string' do
    input_parser = InputParser.new(filename)
    expect(input_parser.filename).to be_a(String)
  end

  it 'can check that a vaild filename has been passed' do
    input_parser = InputParser.new(filename)
    expect(input_parser.valid_filename?).to be(TRUE)
  end

  it 'can modify the filename' do
    input_parser = InputParser.new(filename)
    expect(input_parser.filename).to match('test_input.txt')
    input_parser.filename = 'newfilename.txt'
    expect(input_parser.filename).to match('newfilename.txt')
  end

  context 'invalid filename' do
    it 'should return false and raise error' do
      input_parser = InputParser.new(invalid_filename)
      expect(input_parser.valid_filename?).to be(FALSE)
      expect { input_parser.validate_input }.to raise_error(
        RuntimeError,
        'Invalid filename, or file does not exist')
    end
  end

  context 'invalid instructions in file' do
    it 'should raise an error' do
      input_parser = InputParser.new(invalid_input)
      expect(input_parser.valid_filename?).to be(TRUE)
      expect { input_parser.validate_input }.to raise_error(
        RuntimeError,
        'Invalid or missing plateau dimensions')
    end
  end

  it 'will parse the contents of a file' do
    input_parser = InputParser.new(filename)
    input_parser.parse_file
    expect(input_parser.plateau_dimensions).to match_array [5, 5]
    expect(input_parser.rover_input).to match_array [
      {:coords_x=>1, :coords_y=>2, :orientation=>'N', :sequence=>'LMLMLMLMM'},
      {:coords_x=>3, :coords_y=>3, :orientation=>'E', :sequence=>'MMRMMRMRRM'}
    ]
  end
end
