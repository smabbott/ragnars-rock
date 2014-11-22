require 'spec_helper'

describe "photos/edit" do
  before(:each) do
    @photo = assign(:photo, stub_model(Photo,
      :author => "MyString",
      :location_id => 1
    ))
  end

  it "renders the edit photo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", photo_path(@photo), "post" do
      assert_select "input#photo_author[name=?]", "photo[author]"
      assert_select "input#photo_location_id[name=?]", "photo[location_id]"
    end
  end
end
