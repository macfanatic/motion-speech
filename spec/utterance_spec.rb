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
  end

end
