require 'spec_helper'

describe Flicket, :vcr do
  it 'can be run from command line' do
    expect(File.stat('./bin/flicket').executable?).to be true
  end

  it 'has a version number' do
    expect(Flicket::VERSION).not_to be nil
  end

  before do
    # Set environment variables to something
    # which works because VCR intercepts the real requests anyway
    ENV['FLICKR_KEY'] ||= '123'
    ENV['FLICKR_SECRET'] ||= '456'
  end
  it 'runs successfully' do
    expect { described_class::CLI.start(['hello', 'flickr', '-o', 'collage.png']) }.to_not raise_error
  end
end
