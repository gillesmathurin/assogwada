require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/nl_contents/edit.html.erb" do
  include NlContentsHelper
  
  before do
    @nl_content = mock_model(NlContent)
    @nl_content.stub!(:titre).and_return("MyString")
    @nl_content.stub!(:body).and_return("MyText")
    @nl_content.stub!(:newsletter_id).and_return("1")
    assigns[:nl_content] = @nl_content
  end

  it "should render edit form" do
    render "/nl_contents/edit.html.erb"
    
    response.should have_tag("form[action=#{nl_content_path(@nl_content)}][method=post]") do
      with_tag('input#nl_content_titre[name=?]', "nl_content[titre]")
      with_tag('textarea#nl_content_body[name=?]', "nl_content[body]")
    end
  end
end


