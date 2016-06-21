require 'spec_helper'
require 'flicket/flicker_query'

describe Flicket::FlickerQuery do
  let(:search_results) {
    [{"id"=>"17189154479", "owner"=>"41755442@N06", "secret"=>"2042e5587b", "server"=>"7690", "farm"=>8, "title"=>"Wood Duck", "ispublic"=>1, "isfriend"=>0, "isfamily"=>0}]
  }
  let(:sizes_results) {
    [
      {"label"=>"Square", "width"=>75, "height"=>75, "source"=>"https://farm8.staticflickr.com/7690/17189154479_2042e5587b_s.jpg", "url"=>"https://www.flickr.com/photos/41755442@N06/17189154479/sizes/sq/", "media"=>"photo"},
      {"label"=>"Large Square", "width"=>"150", "height"=>"150", "source"=>"https://farm8.staticflickr.com/7690/17189154479_2042e5587b_q.jpg", "url"=>"https://www.flickr.com/photos/41755442@N06/17189154479/sizes/q/", "media"=>"photo"},
      {"label"=>"Thumbnail", "width"=>"100", "height"=>"66", "source"=>"https://farm8.staticflickr.com/7690/17189154479_2042e5587b_t.jpg", "url"=>"https://www.flickr.com/photos/41755442@N06/17189154479/sizes/t/", "media"=>"photo"}]
  }
  let(:subject) { described_class.new(search_command: search_command, sizes_command: sizes_command) }
  let(:search_command) { double('search', call: search_results ) }
  let(:sizes_command) { double('sizes', call: sizes_results)}

  context 'successful search' do
    it 'returns photo url for keyword' do
      expect(subject.call 'zzz').to eq('https://farm8.staticflickr.com/7690/17189154479_2042e5587b_q.jpg')
    end
  end

  context 'keyword missing' do
    it 'raises exception' do
        expect { subject.call nil }.to raise_error Flicket::KeywordMissing
    end
  end

  context 'no image for keyword' do
    let(:search_command) { double('search', call: [] ) }
    it 'raises exception' do
      expect { subject.call 'zup' }.to raise_error Flicket::NoImageForKeyword
    end
  end
end
