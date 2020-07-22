Encode and decode Google Polylines. To use it:

```playground
require "./src/polylines"

Polylines.encode([{lat: 38.5, lng: -120.2}, {lat: 40.7, lng: -120.95}])
Polylines.encode([[38.5, -120.2], [40.7, -120.95]])
Polylines.encode([{38.5, -120.2}, {40.7, -120.95}])
# => "_p~iF~ps|U_ulLnnqC"

Polylines.decode("_p~iF~ps|U_ulLnnqC")
# => [{lat: 38.5, lng: -120.2}, {lat: 40.7, lng: -120.95}]
```

You can also set precision in both methods as the second positionnal argument
It will correspond to the number of values after the comma.

Please **do not** set precision to more than 10...

[![40 digits: You are optimistic about our understanding of the nature of distance itself.](https://imgs.xkcd.com/comics/coordinate_precision.png)](https://www.explainxkcd.com/wiki/index.php/2170:_Coordinate_Precision)
