describe Motion::Speech::Speaker do

  describe 'initialization' do

    it "creates new instance when calling #speak" do
      speaker = Motion::Speech::Speaker.speak "lorem"
      speaker.should.be.instance_of Motion::Speech::Speaker
    end

    it "stores message" do
      speaker = Motion::Speech::Speaker.new "lorem"
      speaker.message.should.be.equal "lorem"
    end

    it "accepts an options hash" do
      speaker = Motion::Speech::Speaker.new "lorem", key: :value
      speaker.options.should.be.equal key: :value
    end

    it "calls #to_speakable on sentence if supported" do
      sentence = Speakable.new("lorem")
      speaker = Motion::Speech::Speaker.new sentence
      speaker.message.should.be.equal sentence.to_speakable
    end
  end

  describe '#utterance' do
    before do
      @speaker = Motion::Speech::Speaker.new "lorem"
    end

    it "returns an AVSpeechUtterance instance" do
      @speaker.utterance.should.be.instance_of AVSpeechUtterance
    end

    describe '#rate' do

      it "sets the speech rate to a reasonable default" do
        @speaker.utterance.rate.should.be.equal 0.15
      end

      it "allows me to override the rate" do
        speaker = Motion::Speech::Speaker.new "lorem", rate: 0.75
        speaker.utterance.rate.should.be.equal 0.75
      end
    end
  end

  describe '#synthesizer' do
    before do
      @speaker = Motion::Speech::Speaker.new "lorem"
    end

    it "returns an AVSpeechSynthesizer" do
      @speaker.synthesizer.should.be.instance_of AVSpeechSynthesizer
    end

    it "is the synthesizer delegate" do
      @speaker.synthesizer.delegate.should.be.equal @speaker
    end
  end

  describe 'events' do

    describe 'block without arguments' do
      before do
        @speaker = Motion::Speech::Speaker.new("lorem") { @called_block = true }
      end

      it "calls the block on completion" do
        @called_block.should.be.nil

        # Send delegate message immediately, AVFoundation is tested
        @speaker.send 'speechSynthesizer:didFinishSpeechUtterance:', @speaker.synthesizer, @speaker.utterance
        @called_block.should.be.true
      end
    end

    describe 'block with too many arguments' do
      it "raises an exception" do
        should.raise(ArgumentError) do
          Motion::Speech::Speaker.new("lorem") do |arg1, arg2|
          end
        end
      end
    end

    describe 'block with 1 argument' do

      it "calls the start block" do
        speaker = Motion::Speech::Speaker.new "lorem" do |events|
          events.start { @called_block = true }
        end

        @called_block = nil
        @called_block.should.be.nil

        # Send delegate message immediately, AVFoundation is tested      
        speaker.send 'speechSynthesizer:didStartSpeechUtterance:', speaker.synthesizer, speaker.utterance
        @called_block.should.be.true
      end

      it "calls the finish block" do
        speaker = Motion::Speech::Speaker.new "lorem" do |events|
          events.finish { @called_block = true }
        end

        @called_block = nil
        @called_block.should.be.nil

        # Send delegate message immediately, AVFoundation is tested      
        speaker.send 'speechSynthesizer:didFinishSpeechUtterance:', speaker.synthesizer, speaker.utterance
        @called_block.should.be.true
      end
    end

  end
end
