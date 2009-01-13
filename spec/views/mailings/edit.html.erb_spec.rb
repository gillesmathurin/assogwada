require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/mailings/edit.html.erb" do
  include MailingsHelper
  
  before do
    @mailing = mock_model(Mailing)
    @mailing.stub!(:objet).and_return("MyString")
    @mailing.stub!(:body).and_return("MyText")
    @mailing.stub!(:published_at).and_return(Time.now)
    @mailing.stub!(:numero).and_return("1")
    assigns[:mailing] = @mailing
  end

  it "should render edit form" do
    render "/mailings/edit.html.erb"
    
    response.should have_tag("form[action=#{mailing_path(@mailing)}][method=post]") do
      with_tag('input#mailing_objet[name=?]', "mailing[objet]")
      with_tag('textarea#mailing_body[name=?]', "mailing[body]")
      with_tag('input#mailing_numero[name=?]', "mailing[numero]")
    end
  end
end


