require 'spec_helper'

describe Flicket::KeywordSource do
  let(:dict_path) { "#{spec_folder}/fixtures/dict.txt" }
  let(:dict_contents) { File.readlines(dict_path).map(&:strip) }
  let(:subject) { described_class.new dict_path }

  it 'returns words from dictionary' do
    expect(dict_contents).to include subject.call
  end

  it 'returns user words first, then falls to dictionary' do
    subject.add_user_words ['zzumba', 'bbumba']
    expect(subject.call).to eq 'zzumba'
    expect(subject.call).to eq 'bbumba'
    expect(dict_contents).to include subject.call
  end
end
