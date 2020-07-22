require "./spec_helper"

describe Polylines do
  points = [{lat: 38.5, lng: -120.2}, {lat: 40.7, lng: -120.95}, {lat: 43.252, lng: -126.453}]
  polyline = "_p~iF~ps|U_ulLnnqC_mqNvxq`@"

  describe ".encode" do
    it "encodes" do
      Polylines.decode(polyline).should eq points
    end
  end

  describe ".decode" do
    it "decodes" do
      Polylines.encode(points).should eq polyline
    end
  end

  it "works" do
    Polylines.encode(Polylines.decode(polyline)).should eq polyline
  end
end
