require_relative '../../spec_helper'
require_relative 'spec_helper'
require_relative 'fixtures/server'

describe "Net::FTP#nlst" do
  before :each do
    @server = NetFTPSpecs::DummyFTP.new
    @server.serve_once

    @ftp = Net::FTP.new
    @ftp.passive = false
    @ftp.connect(@server.hostname, @server.server_port)
  end

  after :each do
    @ftp.quit rescue nil
    @ftp.close
    @server.stop
  end

  describe "when passed no arguments" do
    it "returns an Array containing a list of files in the current dir" do
      @ftp.nlst.should == ["last_response_code.rb", "list.rb", "pwd.rb"]
      @ftp.last_response.should == "226 transfer complete (NLST)\n"
    end
  end

  describe "when passed dir" do
    it "returns an Array containing a list of files in the passed dir" do
      @ftp.nlst("test.folder").should == ["last_response_code.rb", "list.rb", "pwd.rb"]
      @ftp.last_response.should == "226 transfer complete (NLST test.folder)\n"
    end
  end

  describe "when the NLST command fails" do
    it "raises a Net::FTPTempError when the response code is 450" do
      @server.should_receive(:nlst).and_respond("450 Requested file action not taken..")
      -> { @ftp.nlst }.should raise_error(Net::FTPTempError)
    end

    it "raises a Net::FTPPermError when the response code is 500" do
      @server.should_receive(:nlst).and_respond("500 Syntax error, command unrecognized.")
      -> { @ftp.nlst }.should raise_error(Net::FTPPermError)
    end

    it "raises a Net::FTPPermError when the response code is 501" do
      @server.should_receive(:nlst).and_respond("501 Syntax error, command unrecognized.")
      -> { @ftp.nlst }.should raise_error(Net::FTPPermError)
    end

    it "raises a Net::FTPPermError when the response code is 502" do
      @server.should_receive(:nlst).and_respond("502 Command not implemented.")
      -> { @ftp.nlst }.should raise_error(Net::FTPPermError)
    end

    it "raises a Net::FTPTempError when the response code is 421" do
      @server.should_receive(:nlst).and_respond("421 Service not available, closing control connection.")
      -> { @ftp.nlst }.should raise_error(Net::FTPTempError)
    end

    it "raises a Net::FTPPermError when the response code is 530" do
      @server.should_receive(:nlst).and_respond("530 Not logged in.")
      -> { @ftp.nlst }.should raise_error(Net::FTPPermError)
    end
  end

  describe "when opening the data port fails" do
    it "raises a Net::FTPPermError when the response code is 500" do
      @server.should_receive(:eprt).and_respond("500 Syntax error, command unrecognized.")
      @server.should_receive(:port).and_respond("500 Syntax error, command unrecognized.")
      -> { @ftp.nlst }.should raise_error(Net::FTPPermError)
    end

    it "raises a Net::FTPPermError when the response code is 501" do
      @server.should_receive(:eprt).and_respond("501 Syntax error in parameters or arguments.")
      @server.should_receive(:port).and_respond("501 Syntax error in parameters or arguments.")
      -> { @ftp.nlst }.should raise_error(Net::FTPPermError)
    end

    it "raises a Net::FTPTempError when the response code is 421" do
      @server.should_receive(:eprt).and_respond("421 Service not available, closing control connection.")
      @server.should_receive(:port).and_respond("421 Service not available, closing control connection.")
      -> { @ftp.nlst }.should raise_error(Net::FTPTempError)
    end

    it "raises a Net::FTPPermError when the response code is 530" do
      @server.should_receive(:eprt).and_respond("530 Not logged in.")
      @server.should_receive(:port).and_respond("530 Not logged in.")
      -> { @ftp.nlst }.should raise_error(Net::FTPPermError)
    end
  end
end
