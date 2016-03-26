
require_relative '../app/mars_base'

describe MarsBase do
  let(:filename) { 'test_input.txt' }
  let(:invalid_filename) { 'does_not_exist.txt' }
  let(:invalid_input) { 'invalid_input.txt' }

  it 'can initialize' do
    mars_base = MarsBase.new(filename)
    expect(mars_base.filename).to match('test_input.txt')
    expect(mars_base.rover_missions).to match_array []
    expect(mars_base.rovers).to match_array []
  end

  it 'will store the filename as a string' do
    mars_base = MarsBase.new(filename)
    expect(mars_base.filename).to be_a(String)
  end

  it 'can check that a vaild filename has been passed' do
    mars_base = MarsBase.new(filename)
    expect(mars_base.valid_filename?).to be(TRUE)
  end

  it 'can modify the filename' do
    mars_base = MarsBase.new(filename)
    expect(mars_base.filename).to match('test_input.txt')
    mars_base.filename = 'newfilename.txt'
    expect(mars_base.filename).to match('newfilename.txt')
  end

  context 'invalid filename' do
    it 'should return false and raise error' do
      mars_base = MarsBase.new(invalid_filename)
      expect(mars_base.valid_filename?).to be(FALSE)
      expect { mars_base.validate_input }.to raise_error(
        RuntimeError,
        'Invalid filename, or file does not exist')
    end
  end

  context 'invalid instructions in file' do
    it 'should raise an error' do
      mars_base = MarsBase.new(invalid_input)
      expect(mars_base.valid_filename?).to be(TRUE)
      expect { mars_base.validate_input }.to raise_error(
        RuntimeError,
        'Invalid or missing plateau dimensions')
    end
  end

  it 'will extract the plateau dimensions' do
    mars_base = MarsBase.new(filename)
    instructions = File.readlines(filename)
    expect(mars_base.extract_plateau_input(instructions)).to match_array [5, 5]
  end

  it 'creates and stores a rover mission for each set of commands' do
    mars_base = MarsBase.new(filename)
    mars_base.run
    expect(mars_base.rover_missions.length).to eq(2)
  end

  it 'can output each rover location' do
    mars_base = MarsBase.new(filename)
    mars_base.run
    expect(mars_base.rover_report).to match("1 3 N\n5 1 E\n")
  end
end
