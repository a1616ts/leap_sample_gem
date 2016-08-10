require 'spec_helper'

describe LeapSampleGem do
  it 'has a version number' do
    expect(LeapSampleGem::VERSION).not_to be nil
  end

  it 'has sample file' do
    expect(File.exist?('lib/leap_sample_gem/ubiquitous_demo.rb')).to be true
  end
end
