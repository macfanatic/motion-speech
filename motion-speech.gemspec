# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'motion/speech/version'

Gem::Specification.new do |s|
  s.name          = "motion-speech"
  s.version       = Motion::Speech::VERSION
  s.authors       = ["Matt Brewer"]
  s.email         = ["matt.brewer@me.com"]
  s.homepage      = "https://github.com//motion-speech"
  s.summary       = "Get your iOS app to talk the easy way."
  s.description   = "Provides a simple interface for using the AVSpeechSynthesizer related classes available natively in iOS 7."
  s.license       = "MIT"

  s.files         =  Dir["lib/**/*"] + ["README.md"]
  s.test_files    = Dir["spec/**/*"]
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.rubyforge_project = '[none]'

  s.add_development_dependency "rake"
end
