require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/nl_contents/show.html.erb" do
  include NlContentsHelper
  
  before(:each) do
    @nl_content = mock_model(NlContent)
    @nl_content.stub!(:titre).and_return("MyString")
    @nl_content.stub!(:body).and_return("MyText")
    @nl_content.stub!(:newsletter_id).and_return("1")

    assigns[:nl_content] = @nl_content
  end

  it "should render attributes in <p>" do
    render "/nl_contents/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
  end
end

