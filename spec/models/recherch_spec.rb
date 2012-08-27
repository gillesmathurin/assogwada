# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Recherch do
  before(:each) do
    @recherch = Recherch.new
  end

  it "should be valid" do
    @recherch.should be_valid
  end
end
