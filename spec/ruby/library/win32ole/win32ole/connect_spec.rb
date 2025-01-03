require_relative "../../../spec_helper"
platform_is :windows do
  verbose, $VERBOSE = $VERBOSE, nil

  require_relative '../fixtures/classes'

  describe "WIN32OLE.connect" do
    it "creates WIN32OLE object given valid argument" do
      obj = WIN32OLE.connect("winmgmts:")
      obj.should be_kind_of WIN32OLE
    end

    it "raises TypeError when given invalid argument" do
      -> { WIN32OLE.connect 1 }.should raise_error TypeError
    end

  end
ensure
  $VERBOSE = verbose
end
