require 'spec_helper'

describe "days/index" do
  before(:each) do
    assign(:days, [
      stub_model(Day,
        :path => ""
      ),
      stub_model(Day,
        :path => ""
      )
    ])
  end

  it "renders a list of days" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
