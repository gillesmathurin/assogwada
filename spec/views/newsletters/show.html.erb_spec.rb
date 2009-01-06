require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/newsletters/show.html.erb" do
  include NewslettersHelper
  
  before(:each) do
    @newsletter = mock_model(Newsletter)
    @newsletter.stub!(:date_pub).and_return(Date.today)
    @newsletter.stub!(:numero).and_return("1")

    assigns[:newsletter] = @newsletter
  end

  it "should render attributes in <p>" do
    render "/newsletters/show.html.erb"
    response.should have_text(/1/)
  end
end

