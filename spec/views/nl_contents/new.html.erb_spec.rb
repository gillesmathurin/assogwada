require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/nl_contents/new.html.erb" do
  include NlContentsHelper
  
  before(:each) do
    @nl_content = mock_model(NlContent)
    @nl_content.stub!(:new_record?).and_return(true)
    @nl_content.stub!(:titre).and_return("MyString")
    @nl_content.stub!(:body).and_return("MyText")
    @nl_content.stub!(:newsletter_id).and_return("1")
    assigns[:nl_content] = @nl_content
  end

  it "should render new form" do
    render "/nl_contents/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", nl_contents_path) do
      with_tag("input#nl_content_titre[name=?]", "nl_content[titre]")
      with_tag("textarea#nl_content_body[name=?]", "nl_content[body]")
    end
  end
end


