require 'spec_helper'

describe Array do
  it "should the options hash from an array" do
    a = [:name, {:email=>{:label=>"test"}}, :website]
    expected = {:name=>{},:email=>{:label=>"test"},:website=>{}}
    a.to_options_hash.should eq expected
  end
  
  it "should return empty hash if no options in array" do
    a = []
    expected = {}
    a.to_options_hash.should eq expected
  end
end