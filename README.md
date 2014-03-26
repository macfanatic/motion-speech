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

## Advanced Usage
There are several more advanced examples that you can follow below, allowing more customization of the utterance playback including voices (coming soon) as well as contriving arbitrary objects for speech.

```ruby
class Name < String
  def to_speakable
    "My name is #{self}"
  end
end

my_name = Name.new("Matt Brewer")
Motion::Speech::Speaker.speak my_name
# => "My name is Matt Brewer" spoken
```
