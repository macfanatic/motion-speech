describe Motion::Speech::Utterance do

  before do
    @message = "lorem"
  end

  describe '#message' do
    it "stores the message on initialization" do
      utterance = Motion::Speech::Utterance.new(@message)
      utterance.speechString.should.be.equal @message
    end

    it "provides a :message accessor" do
      utterance = Motion::Speech::Utterance.new(@message)
      utterance.message.should.be.equal @message

      utterance.message = "change the message"
      utterance.message.should.be.equal "change the message"
    end

    it "calls :to_speakable" do
      sentence = Speakable.new("lorem")
      utterance = Motion::Speech::Utterance.new(sentence)
      utterance.message.should.be.equal sentence.to_speakable
    end
  end

  describe '#pitch' do
    it "provides a #pitch accessor" do
      utterance = Motion::Speech::Utterance.new(@message)
      utterance.pitchMultiplier.should.be.equal utterance.pitch
    end

    it "allows customization on initialization" do
      utterance = Motion::Speech::Utterance.new(@message, pitch: 0.5)
      utterance.pitch.should.be.equal 0.5
    end
  end

  describe '#rate' do
    it "provides a default rate" do
      utterance = Motion::Speech::Utterance.new(@message)
      utterance.rate.should.be.equal 0.15
    end

    it "overrides rate" do
      utterance = Motion::Speech::Utterance.new(@message, rate: 1)
      utterance.rate.should.be.equal 1
    end

    it "accepts a symbol for :minimum" do
      utterance = Motion::Speech::Utterance.new(@message, rate: :minimum)
      utterance.rate.should.be.equal AVSpeechUtteranceMinimumSpeechRate
    end

    it "accepts a symbol for :maximum" do
      utterance = Motion::Speech::Utterance.new(@message, rate: :maximum)
      utterance.rate.should.be.equal AVSpeechUtteranceMaximumSpeechRate
    end

    it "accepts a symbol for :default" do
      utterance = Motion::Speech::Utterance.new(@message, rate: :default)
      utterance.rate.should.be.equal AVSpeechUtteranceDefaultSpeechRate
    end

    it "raises an error when passed an unrecognized symbol" do
      @utterance = Motion::Speech::Utterance.new @message
      ->{ @utterance.rate = :unknown }.should.raise(ArgumentError)
    end
  end

end
