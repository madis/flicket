require 'spec_helper'
require 'flicket/app'
require 'flicket/environment'
require 'ostruct'
describe Flicket::App do
  let(:result) { '/tmp/it_is_good' }
  let(:flicker_query) { ->(keyword) {} }

  let(:env) { Flicket::Environment.new(
    flicker_query: flicker_query,
    downloader: ->(url) {},
    keyword_source: -> {},
    cropper: ->(path) {},
    collage_maker: ->(path) {},
    storage: ->(path) { result }
    ) }

  let(:subject) { described_class.new(env) }

  it 'uses process chain to create collage' do
    expect(subject.call).to eq result
  end

  context 'image not found' do
    let(:flicker_query) { ->(keyword) { raise Flicket::NoImageForKeyword } }

    it 'retries 10 times' do
      expect(env.keyword_source).to receive(:call).exactly(10).times
      expect(subject.call).to be_nil
    end
  end
end
