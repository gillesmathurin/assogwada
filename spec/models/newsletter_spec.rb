require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Newsletter do
  before(:each) do
    @newsletter = Newsletter.new
  end

  it "should be valid" do
    @newsletter.should be_valid
  end
end
