# Crystal Lang Polylines


[![Release](https://img.shields.io/github/release/BuonOmo/polylines.cr.svg)](https://github.com/BuonOmo/polylines.cr/releases)
[![Build Status](https://travis-ci.org/BuonOmo/polylines.cr.svg?branch=master)](https://travis-ci.org/BuonOmo/polylines.cr)
[![Docs](https://img.shields.io/badge/docs-available-brightgreen.svg)](https://buonomo.github.io/polylines.cr/)


A Crystal implementation of the [Google polyline algorithm](https://code.google.com/apis/maps/documentation/utilities/polylinealgorithm.html).

Greatly inspired by the Ruby implementation [fast-polylines](https://github.com/klaxit/fast-polylines), it is mostly
existing for performance comparison between Ruby C extensions and Crystal!

If you are curious: encoding is roughly the same, decoding is way faster in Crystal.
If you are even more curious, `make benchmark` here and in [fast-polylines](https://github.com/klaxit/fast-polylines) 😉.
With a MacBook pro 1,4 GHz i5, here's the result:

```text
——————————————————————————————— ENCODING ————————————————————————————————

CrystalPolylines 706.82k (  1.41µs) (± 4.42%)  466B/op  fastest

———————————————————————————————  DECODING ————————————————————————————————

CrystalPolylines   1.43M (699.73ns) (± 3.21%)  1.62kB/op  fastest
```

## Installation

Add the dependency to your `shard.yml`:

```yaml
dependencies:
  polylines:
    github: BuonOmo/polylines.cr
```

Run `shards install`

## Usage

```crystal
require "polylines"

# Polylines.encode(array, precision = 5)
Polylines.encode([[38.5, -120.2], [40.7, -120.95], [43.252, -126.453]])
# Polylines.decode(polyline, precision = 5)
Polylines.decode("_p~iF~ps|U_ulLnnqC_mqNvxq`@")

Polylines.encode([[12.1232493, 2.9481493], [13.8474392, 16.8373924]], 7)
```

## Contributing

1. Fork it ([BuonOmo/polylines.cr/fork](https://github.com/BuonOmo/polylines.cr/fork))
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
