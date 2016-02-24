# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xctester/version'

Gem::Specification.new do |spec|
  spec.name          = "xctester"
  spec.version       = Xctester::VERSION
  spec.authors       = ["Arnaud Schildknecht"]
  spec.email         = ["arnaud.schild@gmail.com"]

  spec.summary       = %q{A basic script that run Xcode tests.}
  spec.homepage      = "https://github.com/Nonouf/xctester"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "OptionParser", "~> 0.5"
  spec.add_dependency "POpen4", "~> 0.1"
  spec.add_dependency "colorize", "~> 0.7"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
