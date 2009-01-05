require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Association do
  before(:each) do
    @association = Association.new
  end

  it "should be valid" do
    @association.should be_valid
  end
end