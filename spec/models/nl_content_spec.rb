require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NlContent do
  before(:each) do
    @nl_content = NlContent.new
  end

  it "should be valid" do
    @nl_content.should be_valid
  end
end
