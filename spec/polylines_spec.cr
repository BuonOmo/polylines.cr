require "./spec_helper"

describe Location do
  it "behaves as an array" do
    loc = Location.new(1.0, 2.0)
    loc[0].should eq 1.0
    loc[1].should eq 2.0
    expect_raises(IndexError) { loc[2] }
  end
end

describe Polylines do
  points = [[38.5, -120.2], [40.7, -120.95], [43.252, -126.453]]
  polyline = "_p~iF~ps|U_ulLnnqC_mqNvxq`@"

  describe ".encode" do
    it "encodes" do
      Polylines.decode(polyline).map(&.to_a)
        .should eq points
    end
  end

  describe ".decode" do
    it "decodes" do
      Polylines.encode(points)
        .should eq polyline
    end
  end

  it "works" do
    Polylines.encode(Polylines.decode(polyline))
      .should eq polyline
  end
end
