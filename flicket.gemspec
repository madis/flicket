# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flicket/version'

Gem::Specification.new do |spec|
  spec.name          = "flicket"
  spec.version       = Flicket::VERSION
  spec.authors       = ["Madis Nõmme"]
  spec.email         = ["madis.nomme@gmail.com"]

  spec.summary       = %q{Command line tool to create collages of flickr images}
  spec.homepage      = "http://github.com/madis/flicket"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'flickraw', '0.9.8'
  spec.add_development_dependency 'awesome_print', '~>1.7'
  spec.add_development_dependency 'pry', '~>0.10.3'
  spec.add_development_dependency 'vcr', '~>3.0.3'
  spec.add_development_dependency 'webmock', '~>2.1.0'
  spec.add_development_dependency 'mini_magick', '~>4.5.1'
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
