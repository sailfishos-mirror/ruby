require_relative '../../spec_helper'
require_relative 'fixtures/classes'

describe "String#dup" do
  before :each do
    ScratchPad.clear
    @obj = StringSpecs::InitializeString.new "string"
  end

  it "calls #initialize_copy on the new instance" do
    dup = @obj.dup
    ScratchPad.recorded.should_not == @obj.object_id
    ScratchPad.recorded.should == dup.object_id
  end

  it "copies instance variables" do
    dup = @obj.dup
    dup.ivar.should == 1
  end

  it "does not copy singleton methods" do
    def @obj.special() :the_one end
    dup = @obj.dup
    -> { dup.special }.should raise_error(NameError)
  end

  it "does not copy modules included in the singleton class" do
    class << @obj
      include StringSpecs::StringModule
    end

    dup = @obj.dup
    -> { dup.repr }.should raise_error(NameError)
  end

  it "does not copy constants defined in the singleton class" do
    class << @obj
      CLONE = :clone
    end

    dup = @obj.dup
    -> { class << dup; CLONE; end }.should raise_error(NameError)
  end

  it "does not modify the original string when changing dupped string" do
    orig = "string"[0..100]
    dup = orig.dup
    orig[0] = 'x'
    orig.should == "xtring"
    dup.should == "string"
  end

  it "does not modify the original setbyte-mutated string when changing dupped string" do
    orig = +"a"
    orig.setbyte 0, "b".ord
    copy = orig.dup
    orig.setbyte 0, "c".ord
    orig.should == "c"
    copy.should == "b"
  end

  it "returns a String in the same encoding as self" do
    "hello".encode("US-ASCII").dup.encoding.should == Encoding::US_ASCII
  end
end
