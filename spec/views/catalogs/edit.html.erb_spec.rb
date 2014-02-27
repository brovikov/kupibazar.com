require 'spec_helper'

describe "catalogs/edit" do
  before(:each) do
    @catalog = assign(:catalog, stub_model(Catalog,
      :title => "MyString",
      :description => "MyString",
      :img => "MyString"
    ))
  end

  it "renders the edit catalog form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => catalogs_path(@catalog), :method => "post" do
      assert_select "input#catalog_title", :name => "catalog[title]"
      assert_select "input#catalog_description", :name => "catalog[description]"
      assert_select "input#catalog_img", :name => "catalog[img]"
    end
  end
end
