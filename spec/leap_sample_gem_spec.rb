require 'spec_helper'

describe LeapSampleGem do
  it 'has a version number' do
    expect(LeapSampleGem::VERSION).not_to be nil
  end

  it 'has sample files' do
    expect(File.exist?('lib/leap_sample_gem/itunes_controller.rb')).to be true
    expect(File.exist?('lib/leap_sample_gem/motion_gesture_sample.rb')).to be true
    expect(File.exist?('lib/leap_sample_gem/motion_sample.rb')).to be true
    expect(File.exist?('lib/leap_sample_gem/rock_paper_scissors.rb')).to be true
    expect(File.exist?('lib/leap_sample_gem/ubiquitous_demo.rb')).to be true
  end
end
