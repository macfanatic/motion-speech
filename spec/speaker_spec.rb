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

    it "raises exception if you make multiple calls to #speak" do
      speaker = Motion::Speech::Speaker.new "lorem"
      speaker.speak

      should.raise(Motion::Speech::Speaker::MultipleCallsToSpeakError) do
        speaker.speak
      end
    end
  end

  describe '#utterance' do
    before do
      @speaker = Motion::Speech::Speaker.new "lorem"
    end

    it "returns an AVSpeechUtterance instance" do
      @speaker.utterance.should.be.instance_of Motion::Speech::Utterance
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

      it "calls the paused block" do
        speaker = Motion::Speech::Speaker.new "lorem" do |events|
          events.pause { @called_block = true }
        end

        @called_block = nil
        @called_block.should.be.nil

        # Send delegate message immediately, AVFoundation is tested      
        speaker.send 'speechSynthesizer:didPauseSpeechUtterance:', speaker.synthesizer, speaker.utterance
        @called_block.should.be.true
      end

      it "calls the cancelled block" do
        speaker = Motion::Speech::Speaker.new "lorem" do |events|
          events.cancel { @called_block = true }
        end

        @called_block = nil
        @called_block.should.be.nil

        # Send delegate message immediately, AVFoundation is tested      
        speaker.send 'speechSynthesizer:didCancelSpeechUtterance:', speaker.synthesizer, speaker.utterance
        @called_block.should.be.true
      end

      it "calls the resumed block" do
        speaker = Motion::Speech::Speaker.new "lorem" do |events|
          events.resume { @called_block = true }
        end

        @called_block = nil
        @called_block.should.be.nil

        # Send delegate message immediately, AVFoundation is tested      
        speaker.send 'speechSynthesizer:didContinueSpeechUtterance:', speaker.synthesizer, speaker.utterance
        @called_block.should.be.true
      end
    end

  end
end
