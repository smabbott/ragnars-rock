require 'spec_helper'

describe "days/show" do
  before(:each) do
    @day = assign(:day, stub_model(Day,
      :path => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
