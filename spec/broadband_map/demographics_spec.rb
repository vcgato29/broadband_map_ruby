require 'helper'

describe BroadbandMap::Client::Demographics do

  before do
    @client = BroadbandMap::Client.new
  end
  
  describe '.demographics_coords' do
    before do
      stub_get("demographic/fall2010/coordinates?latitude=42.456&longitude=-74.987&format=json&callback=").
        to_return(:status => 200, :body => fixture("demo_coords.json"))
    end
    
    it "should return the correct item" do
      test = @client.demographics_coords({:data_version => 'fall2010', :latitude => 42.456, :longitude => -74.987})
      a_get("demographic/fall2010/coordinates?latitude=42.456&longitude=-74.987&format=json&callback=").should have_been_made
      test.results.medianIncome.should == 44057
    end
  end
  
  describe '.demographics_geo_id' do
    before do
      stub_get("demographic/fall2010/county/ids/17081,17083?format=json&callback=").
        to_return(:status => 200, :body => fixture("demo_geo_id.json"))
    end
    
    it "should return the correct item" do
      test = @client.demographics_geo_id({:data_version => 'fall2010', :geography_type => 'county', :geography_ids => ['17081', '17083']})
      a_get("demographic/fall2010/county/ids/17081,17083?format=json&callback=").should have_been_made
      test.results[0].geographyId.should == '17083'
    end
  end
  
  describe '.demographics_geo_names' do
    before do
      stub_get("demographic/fall2010/county/names/jersey,jefferson?format=json&callback=").
        to_return(:status => 200, :body => fixture("demo_geo_name.json"))
    end
    
    it "should return the correct item" do
      test = @client.demographics_geo_name({:data_version => 'fall2010', :geography_type => 'county', :geography_names => ['jersey', 'jefferson']})
      a_get("demographic/fall2010/county/names/jersey,jefferson?format=json&callback=").should have_been_made
      test.results[0].geographyId.should == '36045'
    end
  end
  
  describe '.demographics_nation' do
    before do
      stub_get("demographic/fall2010/nation?format=json&callback=").
        to_return(:status => 200, :body => fixture("demo_nation.json"))
    end
    
    it "should return the correct item" do
      test = @client.demographics_nation({:data_version => 'fall2010'})
      a_get("demographic/fall2010/nation?format=json&callback=").should have_been_made
      test.results[0].landArea.should == 3803232.4871
    end
  end
  
end