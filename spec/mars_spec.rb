
require_relative '../app/mars_base'

describe MarsBase do
  let(:filename) { 'test_input.txt' }
  let(:invalid_filename) { 'does_not_exist.txt' }
  let(:invalid_input) { 'invalid_input.txt' }

  it 'can initialize' do
    mars_base = MarsBase.new(filename)
    expect(mars_base.rover_missions).to match_array []
    expect(mars_base.rovers).to match_array []
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
