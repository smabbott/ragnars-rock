require 'spec_helper'

describe "sounds/show" do
  before(:each) do
    @sound = assign(:sound, stub_model(Sound,
      :name => "Name",
      :author => "Author",
      :location_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Author/)
    rendered.should match(/1/)
  end
end
