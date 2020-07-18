# Crystal Lang Polylines

[![Shard Version](https://img.shields.io/github/v/tag/BuonOmo/polylines?sort=semver)](https://github.com/BuonOmo/polylines/releases)
[![Build Status](https://travis-ci.org/BuonOmo/polylines.svg?branch=master)](https://travis-ci.org/BuonOmo/polylines)

A Crystal implementation of the [Google polyline algorithm][algorithm].

Greatly inspired by the Ruby implementation [fast-polylines], it is mostly
existing for performance comparison between Ruby C extensions and Crystal!

If you are curious: encoding is slower in crystal, but decoding is roughly the same.
If you are even more curious, `make benchmark` here and in [fast-polylines] :wink:.
With a MacBook pro 1,4 GHz i5, here's the result:

```
——————————————————————————————— ENCODING ————————————————————————————————

CrystalPolylines 140.02k (  7.14µs) (± 7.16%)  14.2kB/op  fastest

———————————————————————————————  DECODING ————————————————————————————————

CrystalPolylines 415.10k (  2.41µs) (± 5.97%)  8.38kB/op  fastest
```

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     polylines:
       github: BuonOmo/polylines
   ```

2. Run `shards install`

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

1. Fork it (<https://github.com/BuonOmo/polylines/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[algorithm]: https://code.google.com/apis/maps/documentation/utilities/polylinealgorithm.html
[fast-polylines]: https://github.com/klaxit/fast-polylines
