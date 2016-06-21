require 'spec_helper'

describe Flicket, :vcr do
  it 'can be run from command line' do
    expect(File.stat('./bin/flicket').executable?).to be true
  end

  it 'has a version number' do
    expect(Flicket::VERSION).not_to be nil
  end

  it 'runs successfully' do
    expect { described_class::CLI.start(['hello', 'flickr']) }.to_not raise_error
  end
end
