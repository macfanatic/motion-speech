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

### Speakable

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

### Callbacks as blocks
This will look somewhat familiar to Rails developers, can work off a system of block callbacks for further control.

```ruby
Motion::Speech::Speaker.speak "lorem" do |events|
  events.start do |speaker|
    puts "started speaking: '#{speaker.message}'"
  end

  events.finish do |speaker|
    puts "finished speaking: '#{speaker.message}'"
  end

  events.pause do |speaker|
    puts "paused while speaking: '#{speaker.message}'"
  end

  events.cancel do |speaker|
    puts "canceled while speaking: '#{speaker.message}'"
  end

  events.resume do |speaker|
    puts "resumed speaking: '#{speaker.message}'"
  end
end
```

### Customizing the speech
You can pass several options directly through the speaker so that the spoken utterance is easily configured as you would like.

```ruby

# To customize the rate
Motion::Speech::Speaker.speak "lorem", rate: :minimum # also accepts, :maximum, :default and any float between 0..1

# To customize the pitch
Motion::Speech::Speaker.speak "lorem", pitch: 2.0 # documentation specifies between 0.5 and 2.0, default being 1.0

# To customize the voice
voice_ref = AVSpeechSynthesisVoice.voiceWithLanguage("some_lang")
Motion::Speech::Speaker.speak "lorem", voice: voice

# To customize the volume
Motion::Speech::Speaker.speak "lorem", volume: 0.5
```


### Using methods for callbacks
This is not unique to RubyMotion, but you can easily grab a block from a method on your class to use as a callback here too.

```ruby
class SomeController < UIViewController

  def tapped_button(*args)
    Motion::Speech::Speaker.speak "lorem" do |events|
      events.start &method(:lock_ui)
      events.finish &method(:unlock_ui)
    end
  end

  private

  def lock_iu(speaker)
    self.view.userInteractionEnabled = false
  end

  def unlock_ui(speaker)
    self.view.userInteractionEnabled = true
  end
end
```

### Controlling playback

```ruby
speaker = Motion::Speech::Speaker.speak "lorem"

# pausing playback accepts symbols or actual structs
speaker.pause :word
speaker.pause :immediate
speaker.pause AVSpeechBoundaryImmediate

speaker.paused?
=> true

speaker.speaking?
=> false

# stopping playback accepts symbols or actual structs
speaker.stop :word
speaker.stop :immediate
speaker.stop AVSpeechBoundaryImmediate

# resume playback
speaker.resume
```
