require 'spec_helper'

describe Video do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :url => "value for url",
      :description => "value for description"
    }
  end

  it "should create a new instance given valid attributes" do
    Video.create!(@valid_attributes)
  end
end
