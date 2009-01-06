require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewslettersController do
  describe "route generation" do

    it "should map { :controller => 'newsletters', :action => 'index' } to /newsletters" do
      route_for(:controller => "newsletters", :action => "index").should == "/newsletters"
    end
  
    it "should map { :controller => 'newsletters', :action => 'new' } to /newsletters/new" do
      route_for(:controller => "newsletters", :action => "new").should == "/newsletters/new"
    end
  
    it "should map { :controller => 'newsletters', :action => 'show', :id => 1 } to /newsletters/1" do
      route_for(:controller => "newsletters", :action => "show", :id => 1).should == "/newsletters/1"
    end
  
    it "should map { :controller => 'newsletters', :action => 'edit', :id => 1 } to /newsletters/1/edit" do
      route_for(:controller => "newsletters", :action => "edit", :id => 1).should == "/newsletters/1/edit"
    end
  
    it "should map { :controller => 'newsletters', :action => 'update', :id => 1} to /newsletters/1" do
      route_for(:controller => "newsletters", :action => "update", :id => 1).should == "/newsletters/1"
    end
  
    it "should map { :controller => 'newsletters', :action => 'destroy', :id => 1} to /newsletters/1" do
      route_for(:controller => "newsletters", :action => "destroy", :id => 1).should == "/newsletters/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'newsletters', action => 'index' } from GET /newsletters" do
      params_from(:get, "/newsletters").should == {:controller => "newsletters", :action => "index"}
    end
  
    it "should generate params { :controller => 'newsletters', action => 'new' } from GET /newsletters/new" do
      params_from(:get, "/newsletters/new").should == {:controller => "newsletters", :action => "new"}
    end
  
    it "should generate params { :controller => 'newsletters', action => 'create' } from POST /newsletters" do
      params_from(:post, "/newsletters").should == {:controller => "newsletters", :action => "create"}
    end
  
    it "should generate params { :controller => 'newsletters', action => 'show', id => '1' } from GET /newsletters/1" do
      params_from(:get, "/newsletters/1").should == {:controller => "newsletters", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'newsletters', action => 'edit', id => '1' } from GET /newsletters/1;edit" do
      params_from(:get, "/newsletters/1/edit").should == {:controller => "newsletters", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'newsletters', action => 'update', id => '1' } from PUT /newsletters/1" do
      params_from(:put, "/newsletters/1").should == {:controller => "newsletters", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'newsletters', action => 'destroy', id => '1' } from DELETE /newsletters/1" do
      params_from(:delete, "/newsletters/1").should == {:controller => "newsletters", :action => "destroy", :id => "1"}
    end
  end
end
