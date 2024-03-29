# frozen_string_literal: false
require_relative '../../spec_helper'
require_relative 'fixtures/classes'

describe "String#prepend" do
  it "prepends the given argument to self and returns self" do
    str = "world"
    str.prepend("hello ").should equal(str)
    str.should == "hello world"
  end

  it "converts the given argument to a String using to_str" do
    obj = mock("hello")
    obj.should_receive(:to_str).and_return("hello")
    a = " world!".prepend(obj)
    a.should == "hello world!"
  end

  it "raises a TypeError if the given argument can't be converted to a String" do
    -> { "hello ".prepend [] }.should raise_error(TypeError)
    -> { 'hello '.prepend mock('x') }.should raise_error(TypeError)
  end

  it "raises a FrozenError when self is frozen" do
    a = "hello"
    a.freeze

    -> { a.prepend "" }.should raise_error(FrozenError)
    -> { a.prepend "test" }.should raise_error(FrozenError)
  end

  it "works when given a subclass instance" do
    a = " world"
    a.prepend StringSpecs::MyString.new("hello")
    a.should == "hello world"
  end

  it "takes multiple arguments" do
    str = " world"
    str.prepend "he", "", "llo"
    str.should == "hello world"
  end

  it "prepends the initial value when given arguments contain 2 self" do
    str = "hello"
    str.prepend str, str
    str.should == "hellohellohello"
  end

  it "returns self when given no arguments" do
    str = "hello"
    str.prepend.should equal(str)
    str.should == "hello"
  end
end
