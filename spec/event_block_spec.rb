describe Motion::Speech::EventBlock do
  before do
    @event = Motion::Speech::EventBlock.new
  end

  it "has has all the events we need" do
    Motion::Speech::EventBlock::Events.should.include 'start'
    Motion::Speech::EventBlock::Events.should.include 'finish'
  end

  it "exposes methods for 'start' and 'finish'" do
    @event.should.respond_to "start"
    @event.should.respond_to "finish"
  end

  it "exposes methods to retrieve the stored block" do
    @event.start { true }
    @event.start.should.be.instance_of Proc
    @event.start.call.should.be.true
  end

  it "allows you to call an event" do
    @event.start { true }
    @event.call(:start, nil).should.be.true
  end
end
