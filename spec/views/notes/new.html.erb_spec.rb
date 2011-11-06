require 'spec_helper'

describe "notes/new.html.erb" do
  before(:each) do
    assign(:note, stub_model(Note,
      :category_id => 1,
      :title => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => notes_path, :method => "post" do
      assert_select "input#note_category_id", :name => "note[category_id]"
      assert_select "input#note_title", :name => "note[title]"
      assert_select "textarea#note_description", :name => "note[description]"
    end
  end
end
