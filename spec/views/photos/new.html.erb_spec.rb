require 'spec_helper'

describe "photos/new" do
  before(:each) do
    assign(:photo, stub_model(Photo,
      :author => "MyString",
      :location_id => 1
    ).as_new_record)
  end

  it "renders new photo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", photos_path, "post" do
      assert_select "input#photo_author[name=?]", "photo[author]"
      assert_select "input#photo_location_id[name=?]", "photo[location_id]"
    end
  end
end
