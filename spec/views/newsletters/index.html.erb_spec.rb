require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/newsletters/index.html.erb" do
  include NewslettersHelper
  
  before(:each) do
    newsletter_98 = mock_model(Newsletter)
    newsletter_98.should_receive(:date_pub).and_return(Date.today)
    newsletter_98.should_receive(:numero).and_return("1")
    newsletter_99 = mock_model(Newsletter)
    newsletter_99.should_receive(:date_pub).and_return(Date.today)
    newsletter_99.should_receive(:numero).and_return("1")

    assigns[:newsletters] = [newsletter_98, newsletter_99]
  end

  it "should render list of newsletters" do
    render "/newsletters/index.html.erb"
    response.should have_tag("tr>td", "1", 2)
  end
end

