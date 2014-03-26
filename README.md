# motion-speech
Provides a simpler interface to using the AVSpeechSynthesizer related classes available natively in iOS 7.

## Installation

Add the following to your project's Gemfile to work with bundler:

```ruby
gem 'motion-speech'
```

Install with bundler:

```shell
bundle install
```

### AVFoundation
This gem includes the `AVFoundation` framework into your project automatically for you.

## Usage
Some basic usage examples are listed below.

```ruby
# Speak a sentence
Motion::Speech::Speaker.speak "Getting started with speech"

# Control the rate of speech
Motion::Speech::Speaker.speak "Getting started with speech", rate: 1

# Pass a block to be called when the speech is completed
Motion::Speech::Speaker.speak "Getting started with speech" do
  puts "completed the utterance"
end
```
