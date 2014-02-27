require 'spec_helper'

describe "catalogs/show" do
  before(:each) do
    @catalog = assign(:catalog, stub_model(Catalog,
      :title => "Title",
      :description => "Description",
      :img => "Img"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Description/)
    rendered.should match(/Img/)
  end
end
