require "./spec_helper"

describe Polylines do
  points = [{lat: 38.5, lng: -120.2}, {lat: 40.7, lng: -120.95}, {lat: 43.252, lng: -126.453}]
  polyline = "_p~iF~ps|U_ulLnnqC_mqNvxq`@"

  describe ".decode" do
    it "decodes" do
      Polylines.decode(polyline).should eq points
    end
  end

  describe ".encode" do
    it "encodes" do
      Polylines.encode(points).should eq polyline
    end

    it "encodes loose values" do
      Polylines.encode(points.map { |point| [point[:lat], point[:lng]] }).should eq polyline
      Polylines.encode(points.map { |point| {point[:lat], point[:lng]} }).should eq polyline
    end
  end

  it "works overall" do
    Polylines.encode(Polylines.decode(polyline)).should eq polyline
  end
end
