require_relative "../../../spec_helper"

platform_is :windows do
  verbose, $VERBOSE = $VERBOSE, nil

  require_relative '../fixtures/classes'

  describe "WIN32OLE#ole_obj_help" do
    before :each do
      @dict = WIN32OLESpecs.new_ole('Scripting.Dictionary')
    end

    it "raises ArgumentError if argument is given" do
      -> { @dict.ole_obj_help(1) }.should raise_error ArgumentError
    end

    it "returns an instance of WIN32OLE_TYPE" do
      @dict.ole_obj_help.kind_of?(WIN32OLE_TYPE).should be_true
    end
  end
ensure
  $VERBOSE = verbose
end
