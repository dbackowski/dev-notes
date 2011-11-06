require 'spec_helper'

describe "notes/edit.html.erb" do
  before(:each) do
    @note = assign(:note, stub_model(Note,
      :category_id => 1,
      :title => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => notes_path(@note), :method => "post" do
      assert_select "input#note_category_id", :name => "note[category_id]"
      assert_select "input#note_title", :name => "note[title]"
      assert_select "textarea#note_description", :name => "note[description]"
    end
  end
end
