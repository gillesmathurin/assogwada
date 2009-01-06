require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NlContentsController do
  describe "handling GET /nl_contents" do

    before(:each) do
      @nl_content = mock_model(NlContent)
      NlContent.stub!(:find).and_return([@nl_content])
    end
  
    def do_get
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end
  
    it "should find all nl_contents" do
      NlContent.should_receive(:find).with(:all).and_return([@nl_content])
      do_get
    end
  
    it "should assign the found nl_contents for the view" do
      do_get
      assigns[:nl_contents].should == [@nl_content]
    end
  end

  describe "handling GET /nl_contents.xml" do

    before(:each) do
      @nl_contents = mock("Array of NlContents", :to_xml => "XML")
      NlContent.stub!(:find).and_return(@nl_contents)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all nl_contents" do
      NlContent.should_receive(:find).with(:all).and_return(@nl_contents)
      do_get
    end
  
    it "should render the found nl_contents as xml" do
      @nl_contents.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /nl_contents/1" do

    before(:each) do
      @nl_content = mock_model(NlContent)
      NlContent.stub!(:find).and_return(@nl_content)
    end
  
    def do_get
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render show template" do
      do_get
      response.should render_template('show')
    end
  
    it "should find the nl_content requested" do
      NlContent.should_receive(:find).with("1").and_return(@nl_content)
      do_get
    end
  
    it "should assign the found nl_content for the view" do
      do_get
      assigns[:nl_content].should equal(@nl_content)
    end
  end

  describe "handling GET /nl_contents/1.xml" do

    before(:each) do
      @nl_content = mock_model(NlContent, :to_xml => "XML")
      NlContent.stub!(:find).and_return(@nl_content)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the nl_content requested" do
      NlContent.should_receive(:find).with("1").and_return(@nl_content)
      do_get
    end
  
    it "should render the found nl_content as xml" do
      @nl_content.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /nl_contents/new" do

    before(:each) do
      @nl_content = mock_model(NlContent)
      NlContent.stub!(:new).and_return(@nl_content)
    end
  
    def do_get
      get :new
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render new template" do
      do_get
      response.should render_template('new')
    end
  
    it "should create an new nl_content" do
      NlContent.should_receive(:new).and_return(@nl_content)
      do_get
    end
  
    it "should not save the new nl_content" do
      @nl_content.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new nl_content for the view" do
      do_get
      assigns[:nl_content].should equal(@nl_content)
    end
  end

  describe "handling GET /nl_contents/1/edit" do

    before(:each) do
      @nl_content = mock_model(NlContent)
      NlContent.stub!(:find).and_return(@nl_content)
    end
  
    def do_get
      get :edit, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end
  
    it "should find the nl_content requested" do
      NlContent.should_receive(:find).and_return(@nl_content)
      do_get
    end
  
    it "should assign the found NlContent for the view" do
      do_get
      assigns[:nl_content].should equal(@nl_content)
    end
  end

  describe "handling POST /nl_contents" do

    before(:each) do
      @nl_content = mock_model(NlContent, :to_param => "1")
      NlContent.stub!(:new).and_return(@nl_content)
    end
    
    describe "with successful save" do
  
      def do_post
        @nl_content.should_receive(:save).and_return(true)
        post :create, :nl_content => {}
      end
  
      it "should create a new nl_content" do
        NlContent.should_receive(:new).with({}).and_return(@nl_content)
        do_post
      end

      it "should redirect to the new nl_content" do
        do_post
        response.should redirect_to(nl_content_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @nl_content.should_receive(:save).and_return(false)
        post :create, :nl_content => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /nl_contents/1" do

    before(:each) do
      @nl_content = mock_model(NlContent, :to_param => "1")
      NlContent.stub!(:find).and_return(@nl_content)
    end
    
    describe "with successful update" do

      def do_put
        @nl_content.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the nl_content requested" do
        NlContent.should_receive(:find).with("1").and_return(@nl_content)
        do_put
      end

      it "should update the found nl_content" do
        do_put
        assigns(:nl_content).should equal(@nl_content)
      end

      it "should assign the found nl_content for the view" do
        do_put
        assigns(:nl_content).should equal(@nl_content)
      end

      it "should redirect to the nl_content" do
        do_put
        response.should redirect_to(nl_content_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @nl_content.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /nl_contents/1" do

    before(:each) do
      @nl_content = mock_model(NlContent, :destroy => true)
      NlContent.stub!(:find).and_return(@nl_content)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the nl_content requested" do
      NlContent.should_receive(:find).with("1").and_return(@nl_content)
      do_delete
    end
  
    it "should call destroy on the found nl_content" do
      @nl_content.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the nl_contents list" do
      do_delete
      response.should redirect_to(nl_contents_url)
    end
  end
end
