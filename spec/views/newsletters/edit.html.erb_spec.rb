require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/newsletters/edit.html.erb" do
  include NewslettersHelper
  
  before do
    @newsletter = mock_model(Newsletter)
    @newsletter.stub!(:date_pub).and_return(Date.today)
    @newsletter.stub!(:numero).and_return("1")
    assigns[:newsletter] = @newsletter
  end

  it "should render edit form" do
    render "/newsletters/edit.html.erb"
    
    response.should have_tag("form[action=#{newsletter_path(@newsletter)}][method=post]") do
      with_tag('input#newsletter_numero[name=?]', "newsletter[numero]")
    end
  end
end


