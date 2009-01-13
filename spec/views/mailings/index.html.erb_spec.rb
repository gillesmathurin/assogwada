require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/mailings/index.html.erb" do
  include MailingsHelper
  
  before(:each) do
    mailing_98 = mock_model(Mailing)
    mailing_98.should_receive(:objet).and_return("MyString")
    mailing_98.should_receive(:body).and_return("MyText")
    mailing_98.should_receive(:published_at).and_return(Time.now)
    mailing_98.should_receive(:numero).and_return("1")
    mailing_99 = mock_model(Mailing)
    mailing_99.should_receive(:objet).and_return("MyString")
    mailing_99.should_receive(:body).and_return("MyText")
    mailing_99.should_receive(:published_at).and_return(Time.now)
    mailing_99.should_receive(:numero).and_return("1")

    assigns[:mailings] = [mailing_98, mailing_99]
  end

  it "should render list of mailings" do
    render "/mailings/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyText", 2)
    response.should have_tag("tr>td", "1", 2)
  end
end

