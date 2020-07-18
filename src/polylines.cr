struct Location
  property lat, lng

  def initialize(@lat : Float64, @lng : Float64)
  end

  def to_a
    [lat, lng]
  end

  def [](index)
    case index
    when 0 then lat
    when 1 then lng
    else
      raise IndexError.new
    end
  end
end

module Polylines
  VERSION = "0.1.0"

  extend self

  def encode(points : Array, precision = 5)
    precision = 10.0 ** precision
    result = String::Builder.new
    last_lat = last_lng = 0
    points.each do |point|
      lat = (point[0] * precision).round.to_i64
      lng = (point[1] * precision).round.to_i64
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
    encode_unsigned_number(sgn_num)
  end

  private def encode_unsigned_number(num)
    encoded = String::Builder.new
    while num >= 0x20
      encoded << ((0x20 | (num & 0x1f)) + 63).chr
      num = num >> 5
    end
    encoded << (num + 63).chr
    encoded.to_s
  end

  def decode(polyline : String, precision = 5)
    precision = 10.0 ** precision
    delta = 0_i64
    shift = 0
    both_coords = false
    lat = 0_i64
    lng = 0_i64
    coords = [] of Location

    polyline.each_byte.map do |byte|
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
          coords << Location.new(lat / precision, lng / precision)
        else
          lat += delta
        end
        delta = 0_i64
        shift = 0
        both_coords = !both_coords
      end
    end.to_a
    coords
  end
end
