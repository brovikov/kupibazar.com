require 'spec_helper'

describe "catalogs/new" do
  before(:each) do
    assign(:catalog, stub_model(Catalog,
      :title => "MyString",
      :description => "MyString",
      :img => "MyString"
    ).as_new_record)
  end

  it "renders new catalog form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => catalogs_path, :method => "post" do
      assert_select "input#catalog_title", :name => "catalog[title]"
      assert_select "input#catalog_description", :name => "catalog[description]"
      assert_select "input#catalog_img", :name => "catalog[img]"
    end
  end
end
