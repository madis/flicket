require 'spec_helper'

describe Flicket do
  it 'has a version number' do
    expect(Flicket::VERSION).not_to be nil
  end

  it 'can be run from command line' do
    expect(`./bin/flicket`).to_not be_nil
  end

  it 'provided keyword is in output when run from command line' do
    expect { system("./bin/flicket first second") }.to output(/first/m).to_stdout_from_any_process
  end

end
