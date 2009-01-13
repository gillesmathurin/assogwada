require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mailing do
  before(:each) do
    @mailing = Mailing.new
  end

  it "should be valid" do
    @mailing.should be_valid
  end
end
