
require_relative '../app/mission_control'

describe MissionControl do
  let(:filename) { 'test_input.txt' }
  let(:invalid_filename) { 'does_not_exist.txt' }
  let(:invalid_input) { 'invalid_input.txt' }

  it 'can initialize' do
    mission = MissionControl.new(filename)
    expect(mission.rover_missions).to match_array []
    expect(mission.rovers).to match_array []
  end

  it 'creates and stores a rover mission for each set of commands' do
    mission = MissionControl.new(filename)
    mission.run
    expect(mission.rover_missions.length).to eq(2)
  end

  it 'can output each rover location' do
    mission = MissionControl.new(filename)
    mission.run
    expect(mission.rover_report).to match("1 3 N\n5 1 E\n")
  end
end
