require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MailingsController do
  describe "handling GET /mailings" do

    before(:each) do
      @mailing = mock_model(Mailing)
      Mailing.stub!(:find).and_return([@mailing])
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
  
    it "should find all mailings" do
      Mailing.should_receive(:find).with(:all).and_return([@mailing])
      do_get
    end
  
    it "should assign the found mailings for the view" do
      do_get
      assigns[:mailings].should == [@mailing]
    end
  end

  describe "handling GET /mailings.xml" do

    before(:each) do
      @mailings = mock("Array of Mailings", :to_xml => "XML")
      Mailing.stub!(:find).and_return(@mailings)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all mailings" do
      Mailing.should_receive(:find).with(:all).and_return(@mailings)
      do_get
    end
  
    it "should render the found mailings as xml" do
      @mailings.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /mailings/1" do

    before(:each) do
      @mailing = mock_model(Mailing)
      Mailing.stub!(:find).and_return(@mailing)
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
  
    it "should find the mailing requested" do
      Mailing.should_receive(:find).with("1").and_return(@mailing)
      do_get
    end
  
    it "should assign the found mailing for the view" do
      do_get
      assigns[:mailing].should equal(@mailing)
    end
  end

  describe "handling GET /mailings/1.xml" do

    before(:each) do
      @mailing = mock_model(Mailing, :to_xml => "XML")
      Mailing.stub!(:find).and_return(@mailing)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the mailing requested" do
      Mailing.should_receive(:find).with("1").and_return(@mailing)
      do_get
    end
  
    it "should render the found mailing as xml" do
      @mailing.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /mailings/new" do

    before(:each) do
      @mailing = mock_model(Mailing)
      Mailing.stub!(:new).and_return(@mailing)
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
  
    it "should create an new mailing" do
      Mailing.should_receive(:new).and_return(@mailing)
      do_get
    end
  
    it "should not save the new mailing" do
      @mailing.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new mailing for the view" do
      do_get
      assigns[:mailing].should equal(@mailing)
    end
  end

  describe "handling GET /mailings/1/edit" do

    before(:each) do
      @mailing = mock_model(Mailing)
      Mailing.stub!(:find).and_return(@mailing)
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
  
    it "should find the mailing requested" do
      Mailing.should_receive(:find).and_return(@mailing)
      do_get
    end
  
    it "should assign the found Mailing for the view" do
      do_get
      assigns[:mailing].should equal(@mailing)
    end
  end

  describe "handling POST /mailings" do

    before(:each) do
      @mailing = mock_model(Mailing, :to_param => "1")
      Mailing.stub!(:new).and_return(@mailing)
    end
    
    describe "with successful save" do
  
      def do_post
        @mailing.should_receive(:save).and_return(true)
        post :create, :mailing => {}
      end
  
      it "should create a new mailing" do
        Mailing.should_receive(:new).with({}).and_return(@mailing)
        do_post
      end

      it "should redirect to the new mailing" do
        do_post
        response.should redirect_to(mailing_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @mailing.should_receive(:save).and_return(false)
        post :create, :mailing => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /mailings/1" do

    before(:each) do
      @mailing = mock_model(Mailing, :to_param => "1")
      Mailing.stub!(:find).and_return(@mailing)
    end
    
    describe "with successful update" do

      def do_put
        @mailing.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the mailing requested" do
        Mailing.should_receive(:find).with("1").and_return(@mailing)
        do_put
      end

      it "should update the found mailing" do
        do_put
        assigns(:mailing).should equal(@mailing)
      end

      it "should assign the found mailing for the view" do
        do_put
        assigns(:mailing).should equal(@mailing)
      end

      it "should redirect to the mailing" do
        do_put
        response.should redirect_to(mailing_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @mailing.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /mailings/1" do

    before(:each) do
      @mailing = mock_model(Mailing, :destroy => true)
      Mailing.stub!(:find).and_return(@mailing)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the mailing requested" do
      Mailing.should_receive(:find).with("1").and_return(@mailing)
      do_delete
    end
  
    it "should call destroy on the found mailing" do
      @mailing.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the mailings list" do
      do_delete
      response.should redirect_to(mailings_url)
    end
  end
end
