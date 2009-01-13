require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/mailings/show.html.erb" do
  include MailingsHelper
  
  before(:each) do
    @mailing = mock_model(Mailing)
    @mailing.stub!(:objet).and_return("MyString")
    @mailing.stub!(:body).and_return("MyText")
    @mailing.stub!(:published_at).and_return(Time.now)
    @mailing.stub!(:numero).and_return("1")

    assigns[:mailing] = @mailing
  end

  it "should render attributes in <p>" do
    render "/mailings/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
    response.should have_text(/1/)
  end
end

