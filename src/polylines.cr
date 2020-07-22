# Encode and decode Google Polylines. To use it:
#
# ```
# Polylines.encode([{lat: 38.5, lng: -120.2}, {lat: 40.7, lng: -120.95}])
# Polylines.encode([[38.5, -120.2], [40.7, -120.95]])
# Polylines.encode([{38.5, -120.2}, {40.7, -120.95}])
# # => "_p~iF~ps|U_ulLnnqC"
#
# Polylines.decode("_p~iF~ps|U_ulLnnqC")
# # => [{lat: 38.5, lng: -120.2}, {lat: 40.7, lng: -120.95}]
# ```
#
# You can also set precision in both methods as the second positionnal argument
# It will correspond to the number of values after the comma.
#
# Please **do not** set precision to more than 10...
#
# [![40 digits: You are optimistic about our understanding of the nature of distance itself.](https://imgs.xkcd.com/comics/coordinate_precision.png)](https://www.explainxkcd.com/wiki/index.php/2170:_Coordinate_Precision)
module Polylines
  VERSION = "0.2.0"

  extend self

  # The default location that will be given by `Polylines.decode`.
  alias Location = NamedTuple(lat: Float64, lng: Float64)
  # The first item must be the lat, and second must be lng.
  alias LatLngLocation = Tuple(Float64, Float64) | Array(Float64)
  # Allows more types to be passed to `Polylines.encode`.
  alias LooseLocation = Location | LatLngLocation

  # Decode a polyline string to an array of tuple `{lat:, lng:}`.
  # The `precision` corresponds to the number of values after the
  # comma, usually between 0 and 9.
  def decode(polyline : String, precision : UInt8 = 5) : Array(Location)
    precision = 10.0 ** precision
    delta = 0_i64
    shift = 0
    both_coords = false
    lat = 0_i64
    lng = 0_i64
    coords = [] of Location

    polyline.each_byte do |byte|
      chunk = byte.to_i64
      unless 63 <= chunk <= 126
        raise ArgumentError.new("Invalid character '#{chunk.chr}'.")
      end

      chunk -= 63
      delta |= ((chunk & ~0x20) << shift)
      shift += 5

      if chunk & 0x20 == 0
        delta = delta & 1 == 0 ? delta >> 1 : ~(delta >> 1)
        if both_coords
          lng += delta
          coords << {lat: lat / precision, lng: lng / precision}
        else
          lat += delta
        end
        delta = 0_i64
        shift = 0
        both_coords = !both_coords
      end
    end
    coords
  end

  # Encode an array of tuple `{lat:, lng:}` to a polyline string.
  # The `precision` corresponds to the number of values after the
  # comma, usually between 0 and 9
  def encode(points : Array(LooseLocation), precision : UInt8 = 5) : String
    # Allocate usually a little bit too much, but avoids having to
    # realloc a lot.
    estimated_polyline_size = points.size * precision * 2
    String.build(estimated_polyline_size) do |io|
      precision = 10.0 ** precision
      last_lat = last_lng = 0_i64
      points.each do |point|
        lat = (lat(point) * precision).round.to_i64
        lng = (lng(point) * precision).round.to_i64
        encode_number(lat - last_lat, io)
        encode_number(lng - last_lng, io)
        last_lat = lat
        last_lng = lng
      end
    end
  end

  private def encode_number(num, io) : Nil
    sgn_num = num << 1
    sgn_num = ~sgn_num if num < 0
    while sgn_num >= 0x20
      io << ((0x20 | (sgn_num & 0x1f)) + 63).chr
      sgn_num = sgn_num >> 5
    end
    io << (sgn_num + 63).chr
  end

  private def lat(point : Location)
    point[:lat]
  end

  private def lng(point : Location)
    point[:lng]
  end

  private def lat(point : LatLngLocation)
    point[0]
  end

  private def lng(point : LatLngLocation)
    point[1]
  end
end
