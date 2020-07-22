require "../src/polylines"
require "benchmark"

POINTS = [
  {lat: 48.85726, lng: 2.35238}, {lat: 48.86685, lng: 2.3209}, {lat: 48.86493, lng: 2.31891},
  {lat: 48.86464, lng: 2.30369}, {lat: 48.86272, lng: 2.29432}, {lat: 48.8538, lng: 2.28262},
  {lat: 48.85162, lng: 2.27885}, {lat: 48.85037, lng: 2.2733}, {lat: 48.85111, lng: 2.27228},
  {lat: 48.84901, lng: 2.26636}, {lat: 48.84795, lng: 2.25668}, {lat: 48.84939, lng: 2.25254},
  {lat: 48.84837, lng: 2.24899}, {lat: 48.84857, lng: 2.22729}, {lat: 48.84711, lng: 2.22407},
  {lat: 48.84238, lng: 2.22211}, {lat: 48.83941, lng: 2.21877}, {lat: 48.83961, lng: 2.19702},
  {lat: 48.83612, lng: 2.18306}, {lat: 48.83166, lng: 2.14879}, {lat: 48.83243, lng: 2.1392},
  {lat: 48.83964, lng: 2.11881}, {lat: 48.84222, lng: 2.09905}, {lat: 48.84196, lng: 2.09547},
  {lat: 48.8128, lng: 2.05831}, {lat: 48.79852, lng: 2.04373}, {lat: 48.79692, lng: 2.04008},
  {lat: 48.79496, lng: 2.04106}, {lat: 48.79544, lng: 2.04537}, {lat: 48.79446, lng: 2.04934},
  {lat: 48.78763, lng: 2.06262}, {lat: 48.77713, lng: 2.06017}, {lat: 48.77094, lng: 2.05524},
  {lat: 48.76883, lng: 2.06241}, {lat: 48.765, lng: 2.06846},
]

POLYLINE =
  "{leiHkmjM}z@vcE~JlKx@b~A~Jpy@vv@bhArLpVxFta@sCjEbL~c@rEn{@_HzXj" \
  "EdUg@rfCbHbSp\\fKpQzSg@|fCxTfvAzZduEyC|z@al@l~BcOnzBr@jUfuDfgFf" \
  "xAbzA~HxUfKcE_B}YbEyWti@_rAr`AhNte@x]dLyk@|Vyd@"

# Puts a Centered, bold and inverted text for better visibility.
def shout_out(string)
  puts "\n\e[7;1m#{string.center(75)}\e[27;0m\n\n"
end

shout_out "ENCODING"

Benchmark.ips do |x|
  x.report("CrystalPolylines") { Polylines.encode(POINTS) }
end

shout_out "DECODING"

Benchmark.ips do |x|
  x.report("CrystalPolylines") { Polylines.decode(POLYLINE) }
end
