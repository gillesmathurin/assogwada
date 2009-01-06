require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NlContentsController do
  describe "route generation" do

    it "should map { :controller => 'nl_contents', :action => 'index' } to /nl_contents" do
      route_for(:controller => "nl_contents", :action => "index").should == "/nl_contents"
    end
  
    it "should map { :controller => 'nl_contents', :action => 'new' } to /nl_contents/new" do
      route_for(:controller => "nl_contents", :action => "new").should == "/nl_contents/new"
    end
  
    it "should map { :controller => 'nl_contents', :action => 'show', :id => 1 } to /nl_contents/1" do
      route_for(:controller => "nl_contents", :action => "show", :id => 1).should == "/nl_contents/1"
    end
  
    it "should map { :controller => 'nl_contents', :action => 'edit', :id => 1 } to /nl_contents/1/edit" do
      route_for(:controller => "nl_contents", :action => "edit", :id => 1).should == "/nl_contents/1/edit"
    end
  
    it "should map { :controller => 'nl_contents', :action => 'update', :id => 1} to /nl_contents/1" do
      route_for(:controller => "nl_contents", :action => "update", :id => 1).should == "/nl_contents/1"
    end
  
    it "should map { :controller => 'nl_contents', :action => 'destroy', :id => 1} to /nl_contents/1" do
      route_for(:controller => "nl_contents", :action => "destroy", :id => 1).should == "/nl_contents/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'nl_contents', action => 'index' } from GET /nl_contents" do
      params_from(:get, "/nl_contents").should == {:controller => "nl_contents", :action => "index"}
    end
  
    it "should generate params { :controller => 'nl_contents', action => 'new' } from GET /nl_contents/new" do
      params_from(:get, "/nl_contents/new").should == {:controller => "nl_contents", :action => "new"}
    end
  
    it "should generate params { :controller => 'nl_contents', action => 'create' } from POST /nl_contents" do
      params_from(:post, "/nl_contents").should == {:controller => "nl_contents", :action => "create"}
    end
  
    it "should generate params { :controller => 'nl_contents', action => 'show', id => '1' } from GET /nl_contents/1" do
      params_from(:get, "/nl_contents/1").should == {:controller => "nl_contents", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'nl_contents', action => 'edit', id => '1' } from GET /nl_contents/1;edit" do
      params_from(:get, "/nl_contents/1/edit").should == {:controller => "nl_contents", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'nl_contents', action => 'update', id => '1' } from PUT /nl_contents/1" do
      params_from(:put, "/nl_contents/1").should == {:controller => "nl_contents", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'nl_contents', action => 'destroy', id => '1' } from DELETE /nl_contents/1" do
      params_from(:delete, "/nl_contents/1").should == {:controller => "nl_contents", :action => "destroy", :id => "1"}
    end
  end
end
