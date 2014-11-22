require 'spec_helper'

describe "sounds/edit" do
  before(:each) do
    @sound = assign(:sound, stub_model(Sound,
      :name => "MyString",
      :author => "MyString",
      :location_id => 1
    ))
  end

  it "renders the edit sound form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", sound_path(@sound), "post" do
      assert_select "input#sound_name[name=?]", "sound[name]"
      assert_select "input#sound_author[name=?]", "sound[author]"
      assert_select "input#sound_location_id[name=?]", "sound[location_id]"
    end
  end
end
