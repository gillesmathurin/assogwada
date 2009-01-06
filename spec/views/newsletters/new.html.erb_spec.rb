require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/newsletters/new.html.erb" do
  include NewslettersHelper
  
  before(:each) do
    @newsletter = mock_model(Newsletter)
    @newsletter.stub!(:new_record?).and_return(true)
    @newsletter.stub!(:date_pub).and_return(Date.today)
    @newsletter.stub!(:numero).and_return("1")
    assigns[:newsletter] = @newsletter
  end

  it "should render new form" do
    render "/newsletters/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", newsletters_path) do
      with_tag("input#newsletter_numero[name=?]", "newsletter[numero]")
    end
  end
end


