require 'spec_helper'
require 'webrick'

describe Flicket::Downloader, :vcr do
  def start_server
    WEBrick::HTTPServer.new(
    Port: random_port,
    DocumentRoot: "#{spec_folder}/fixtures",
    Logger: WEBrick::Log.new("/dev/null"),
    AccessLog: WEBrick::Log.new("/dev/null")
    ).start
  end

  let(:random_port) { rand(20000..65535) }
  let(:server_thread) { Thread.new { start_server } }
  let(:download_url) { "http://0.0.0.0:#{random_port}/dict.txt" }
  let(:original_file) { "#{spec_folder}/fixtures/dict.txt" }
  let(:subject) { described_class.new }

  before do
    server_thread
  end

  after do
    server_thread.kill
  end

  it 'downloads file from url' do
    downloaded_contents = File.read(subject.call(download_url))
    expect(downloaded_contents).to eq(File.read(original_file))
  end
end
