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

  describe 'config block' do
    before do
      @speaker = Motion::Speech::Speaker.new("lorem") { true }
    end

    it "stores the block" do
      @speaker.should.be.has_config
    end
  end
end
