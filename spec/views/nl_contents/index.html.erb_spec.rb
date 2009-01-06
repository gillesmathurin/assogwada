require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/nl_contents/index.html.erb" do
  include NlContentsHelper
  
  before(:each) do
    nl_content_98 = mock_model(NlContent)
    nl_content_98.should_receive(:titre).and_return("MyString")
    nl_content_98.should_receive(:body).and_return("MyText")
    nl_content_98.should_receive(:newsletter_id).and_return("1")
    nl_content_99 = mock_model(NlContent)
    nl_content_99.should_receive(:titre).and_return("MyString")
    nl_content_99.should_receive(:body).and_return("MyText")
    nl_content_99.should_receive(:newsletter_id).and_return("1")

    assigns[:nl_contents] = [nl_content_98, nl_content_99]
  end

  it "should render list of nl_contents" do
    render "/nl_contents/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyText", 2)
  end
end

