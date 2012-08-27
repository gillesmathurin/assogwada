# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Abonne do
  before(:each) do
    @abonne = Abonne.new
  end

  it "should be valid" do
    @abonne.should be_valid
  end
end
