require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MailingsController do
  describe "route generation" do

    it "should map { :controller => 'mailings', :action => 'index' } to /mailings" do
      route_for(:controller => "mailings", :action => "index").should == "/mailings"
    end
  
    it "should map { :controller => 'mailings', :action => 'new' } to /mailings/new" do
      route_for(:controller => "mailings", :action => "new").should == "/mailings/new"
    end
  
    it "should map { :controller => 'mailings', :action => 'show', :id => 1 } to /mailings/1" do
      route_for(:controller => "mailings", :action => "show", :id => 1).should == "/mailings/1"
    end
  
    it "should map { :controller => 'mailings', :action => 'edit', :id => 1 } to /mailings/1/edit" do
      route_for(:controller => "mailings", :action => "edit", :id => 1).should == "/mailings/1/edit"
    end
  
    it "should map { :controller => 'mailings', :action => 'update', :id => 1} to /mailings/1" do
      route_for(:controller => "mailings", :action => "update", :id => 1).should == "/mailings/1"
    end
  
    it "should map { :controller => 'mailings', :action => 'destroy', :id => 1} to /mailings/1" do
      route_for(:controller => "mailings", :action => "destroy", :id => 1).should == "/mailings/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'mailings', action => 'index' } from GET /mailings" do
      params_from(:get, "/mailings").should == {:controller => "mailings", :action => "index"}
    end
  
    it "should generate params { :controller => 'mailings', action => 'new' } from GET /mailings/new" do
      params_from(:get, "/mailings/new").should == {:controller => "mailings", :action => "new"}
    end
  
    it "should generate params { :controller => 'mailings', action => 'create' } from POST /mailings" do
      params_from(:post, "/mailings").should == {:controller => "mailings", :action => "create"}
    end
  
    it "should generate params { :controller => 'mailings', action => 'show', id => '1' } from GET /mailings/1" do
      params_from(:get, "/mailings/1").should == {:controller => "mailings", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'mailings', action => 'edit', id => '1' } from GET /mailings/1;edit" do
      params_from(:get, "/mailings/1/edit").should == {:controller => "mailings", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'mailings', action => 'update', id => '1' } from PUT /mailings/1" do
      params_from(:put, "/mailings/1").should == {:controller => "mailings", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'mailings', action => 'destroy', id => '1' } from DELETE /mailings/1" do
      params_from(:delete, "/mailings/1").should == {:controller => "mailings", :action => "destroy", :id => "1"}
    end
  end
end
