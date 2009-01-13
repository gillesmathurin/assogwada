require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/mailings/new.html.erb" do
  include MailingsHelper
  
  before(:each) do
    @mailing = mock_model(Mailing)
    @mailing.stub!(:new_record?).and_return(true)
    @mailing.stub!(:objet).and_return("MyString")
    @mailing.stub!(:body).and_return("MyText")
    @mailing.stub!(:published_at).and_return(Time.now)
    @mailing.stub!(:numero).and_return("1")
    assigns[:mailing] = @mailing
  end

  it "should render new form" do
    render "/mailings/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", mailings_path) do
      with_tag("input#mailing_objet[name=?]", "mailing[objet]")
      with_tag("textarea#mailing_body[name=?]", "mailing[body]")
      with_tag("input#mailing_numero[name=?]", "mailing[numero]")
    end
  end
end


