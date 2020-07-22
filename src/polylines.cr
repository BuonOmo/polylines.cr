# Encode and decode Google Polylines. To use it:
#
# ```
# Polylines.encode([[38.5, -120.2], [40.7, -120.95], [43.252, -126.453]]) # => "_p~iF~ps|U_ulLnnqC_mqNvxq`@"
# Polylines.decode("_p~iF~ps|U_ulLnnqC_mqNvxq`@")                         # => [{38.5, -120.2}, {40.7, -120.95}, {43.252, -126.453}]
# ```
#
# You can also set precision in both methods as the second positionnal argument
# It will correspond to the number of values after the comma.
#
# Please **do not** set precision to more than 10...
#
# [![40 digits: You are optimistic about our understanding of the nature of distance itself.](https://imgs.xkcd.com/comics/coordinate_precision.png)](https://www.explainxkcd.com/wiki/index.php/2170:_Coordinate_Precision)
module Polylines
  VERSION = "0.1.0"

  extend self

  alias Location = {lat: Float64, lng: Float64}

  # Encode an array of tuple `{lat:, lng:}` to a polyline string.
  # The `precision` corresponds to the number of values after the
  # comma, usually between 0 and 9
  def encode(points : Array(Location), precision : UInt8 = 5) : String
    precision = 10.0 ** precision
    result = String::Builder.new
    last_lat = last_lng = 0
    points.each do |point|
      lat = (point[:lat] * precision).round.to_i64
      lng = (point[:lng] * precision).round.to_i64
      d_lat = lat - last_lat
      d_lng = lng - last_lng
      chunks_lat = encode_number(d_lat)
      chunks_lng = encode_number(d_lng)
      result << chunks_lat << chunks_lng
      last_lat = lat
      last_lng = lng
    end
    result.to_s
  end

  private def encode_number(num)
    sgn_num = num << 1
    sgn_num = ~sgn_num if num < 0
    String.build do |io|
      while sgn_num >= 0x20
        io << ((0x20 | (sgn_num & 0x1f)) + 63).chr
        sgn_num = sgn_num >> 5
      end
      io << (sgn_num + 63).chr
    end
  end

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
end
