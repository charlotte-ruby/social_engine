require 'spec_helper'

describe Hash do

  it "should recursively symbolize itself" do
    test = {"what"=>{"is"=>"this"}}
    expected_result = {:what=>{:is=>"this"}}
    test.recursively_symbolize_keys!.should eq expected_result
  end
  
  it "should merge options and return the defaults if options are blank" do
    defaults = {:name=>{:label=>"Name",:required=>false}, :email=>{:label=>"My Email"}, :website=>"My Website"}
    options = {}
    options.optional_reverse_merge!(defaults).should eq defaults
  end
  
  it "should return only the top level options that are specified as well as the required option" do
    options = {:name=>{:label=>"Name"}}
    defaults = {:name=>{:label=>"Name",:required=>false}, :email=>{:label=>"My Email"}, :website=>"My Website"}
    required = [:website]
    expected = {:name=>{:label=>"Name",:required=>false}, :website=>"My Website"}
    options.optional_reverse_merge!(defaults,required).should eq expected
  end
  
  it "should return only the top level options that are specified" do
    options = {:name=>{:label=>"Name"}}
    defaults = {:name=>{:label=>"Name",:required=>false}, :email=>{:label=>"My Email"}, :website=>"My Website"}
    expected = {:name=>{:label=>"Name",:required=>false}}
    options.optional_reverse_merge!(defaults,[]).should eq expected
  end
end