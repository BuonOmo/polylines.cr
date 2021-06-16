crystal_doc_search_index_callback({"repository_name":"polylines","body":"# Crystal Lang Polylines\n\n\n[![Release](https://img.shields.io/github/release/BuonOmo/polylines.cr.svg)](https://github.com/BuonOmo/polylines.cr/releases)\n[![Build Status](https://travis-ci.org/BuonOmo/polylines.cr.svg?branch=master)](https://travis-ci.org/BuonOmo/polylines.cr)\n[![Docs](https://img.shields.io/badge/docs-available-brightgreen.svg)](https://buonomo.github.io/polylines.cr/)\n\n\nA Crystal implementation of the [Google polyline algorithm](https://code.google.com/apis/maps/documentation/utilities/polylinealgorithm.html).\n\nGreatly inspired by the Ruby implementation [fast-polylines](https://github.com/klaxit/fast-polylines), it is mostly\nexisting for performance comparison between Ruby C extensions and Crystal!\n\nIf you are curious: encoding is roughly the same, decoding is way faster in Crystal.\nIf you are even more curious, `make benchmark` here and in [fast-polylines](https://github.com/klaxit/fast-polylines) 😉.\nWith a MacBook pro 1,4 GHz i5, here's the result:\n\n```text\n——————————————————————————————— ENCODING ————————————————————————————————\n\nCrystalPolylines 706.82k (  1.41µs) (± 4.42%)  466B/op  fastest\n\n———————————————————————————————  DECODING ————————————————————————————————\n\nCrystalPolylines   1.43M (699.73ns) (± 3.21%)  1.62kB/op  fastest\n```\n\n## Installation\n\nAdd the dependency to your `shard.yml`:\n\n```yaml\ndependencies:\n  polylines:\n    github: BuonOmo/polylines.cr\n```\n\nRun `shards install`\n\n## Usage\n\n```crystal\nrequire \"polylines\"\n\nPolylines.encode([{lat: 38.5, lng: -120.2}, {lat: 40.7, lng: -120.95}])\nPolylines.encode([[38.5, -120.2], [40.7, -120.95]])\nPolylines.encode([{38.5, -120.2}, {40.7, -120.95}])\n# => \"_p~iF~ps|U_ulLnnqC\"\n\nPolylines.decode(\"_p~iF~ps|U_ulLnnqC\")\n# => [{lat: 38.5, lng: -120.2}, {lat: 40.7, lng: -120.95}]\n\nPolylines.encode([{lat: 12.1232493, lng: 2.9481493}, {lat: 13.8474392, lng: 16.8373924}], 7)\n# => \"yemffFi`lfw@uqj{_@}gi|gG\"\n\nPolylines.decode(\"yemffFi`lfw@uqj{_@}gi|gG\", 7)\n# => [{lat: 12.1232493, lng: 2.9481493}, {lat: 13.8474392, lng: 16.8373924}]\n```\n\n## Contributing\n\n1. Fork it ([BuonOmo/polylines.cr/fork](https://github.com/BuonOmo/polylines.cr/fork))\n2. Create your feature branch (`git checkout -b my-new-feature`)\n3. Commit your changes (`git commit -am 'Add some feature'`)\n4. Push to the branch (`git push origin my-new-feature`)\n5. Create a new Pull Request\n","program":{"html_id":"polylines/toplevel","path":"toplevel.html","kind":"module","full_name":"Top Level Namespace","name":"Top Level Namespace","abstract":false,"superclass":null,"ancestors":[],"locations":[],"repository_name":"polylines","program":true,"enum":false,"alias":false,"aliased":null,"aliased_html":null,"const":false,"constants":[],"included_modules":[],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":null,"doc":null,"summary":null,"class_methods":[],"constructors":[],"instance_methods":[],"macros":[],"types":[{"html_id":"polylines/Polylines","path":"Polylines.html","kind":"module","full_name":"Polylines","name":"Polylines","abstract":false,"superclass":null,"ancestors":[],"locations":[{"filename":"src/polylines.cr","line_number":19,"url":"https://github.com/BuonOmo/polylines.cr/blob/77041756da90efbd5aa615ff609990ad4be73432/src/polylines.cr#L19"}],"repository_name":"polylines","program":false,"enum":false,"alias":false,"aliased":null,"aliased_html":null,"const":false,"constants":[{"id":"VERSION","name":"VERSION","value":"\"0.2.0\"","doc":null,"summary":null}],"included_modules":[],"extended_modules":[{"html_id":"polylines/Polylines","kind":"module","full_name":"Polylines","name":"Polylines"}],"subclasses":[],"including_types":[],"namespace":null,"doc":"Encode and decode Google Polylines. To use it:\n\n```\nPolylines.encode([{lat: 38.5, lng: -120.2}, {lat: 40.7, lng: -120.95}])\nPolylines.encode([[38.5, -120.2], [40.7, -120.95]])\nPolylines.encode([{38.5, -120.2}, {40.7, -120.95}])\n# => \"_p~iF~ps|U_ulLnnqC\"\n\nPolylines.decode(\"_p~iF~ps|U_ulLnnqC\")\n# => [{lat: 38.5, lng: -120.2}, {lat: 40.7, lng: -120.95}]\n```\n\nYou can also set precision in both methods as the second positionnal argument\nIt will correspond to the number of values after the comma.\n\nPlease **do not** set precision to more than 10...\n\n[![40 digits: You are optimistic about our understanding of the nature of distance itself.](https://imgs.xkcd.com/comics/coordinate_precision.png)](https://www.explainxkcd.com/wiki/index.php/2170:_Coordinate_Precision)","summary":"<p>Encode and decode Google Polylines.</p>","class_methods":[],"constructors":[],"instance_methods":[{"id":"decode(polyline:String,precision:UInt8=5):Array(Location)-instance-method","html_id":"decode(polyline:String,precision:UInt8=5):Array(Location)-instance-method","name":"decode","doc":"Decode a polyline string to an array of tuple `{lat:, lng:}`.\nThe `precision` corresponds to the number of values after the\ncomma, usually between 0 and 9.","summary":"<p>Decode a polyline string to an array of tuple <code>{lat:, lng:}</code>.</p>","abstract":false,"args":[{"name":"polyline","doc":null,"default_value":"","external_name":"polyline","restriction":"String"},{"name":"precision","doc":null,"default_value":"5","external_name":"precision","restriction":"UInt8"}],"args_string":"(polyline : String, precision : UInt8 = <span class=\"n\">5</span>) : Array(Location)","args_html":"(polyline : String, precision : UInt8 = <span class=\"n\">5</span>) : Array(<a href=\"Polylines/Location.html\">Location</a>)","location":{"filename":"src/polylines.cr","line_number":34,"url":"https://github.com/BuonOmo/polylines.cr/blob/77041756da90efbd5aa615ff609990ad4be73432/src/polylines.cr#L34"},"def":{"name":"decode","args":[{"name":"polyline","doc":null,"default_value":"","external_name":"polyline","restriction":"String"},{"name":"precision","doc":null,"default_value":"5","external_name":"precision","restriction":"UInt8"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"Array(Location)","visibility":"Public","body":"precision = 10.0 ** precision\ndelta = 0_i64\nshift = 0\nboth_coords = false\nlat = 0_i64\nlng = 0_i64\ncoords = [] of Location\npolyline.each_byte do |byte|\n  chunk = byte.to_i64\n  if 63 <= chunk && chunk <= 126\n  else\n    raise(ArgumentError.new(\"Invalid character '#{chunk.chr}'.\"))\n  end\n  chunk = chunk - 63\n  delta = delta | ((chunk & (~32)) << shift)\n  shift = shift + 5\n  if (chunk & 32) == 0\n    delta = (delta & 1) == 0 ? delta >> 1 : ~(delta >> 1)\n    if both_coords\n      lng = lng + delta\n      coords << {lat: lat / precision, lng: lng / precision}\n    else\n      lat = lat + delta\n    end\n    delta = 0_i64\n    shift = 0\n    both_coords = !both_coords\n  end\nend\ncoords\n"}},{"id":"encode(points:Array(LooseLocation),precision:UInt8=5):String-instance-method","html_id":"encode(points:Array(LooseLocation),precision:UInt8=5):String-instance-method","name":"encode","doc":"Encode an array of tuple `{lat:, lng:}` to a polyline string.\nThe `precision` corresponds to the number of values after the\ncomma, usually between 0 and 9","summary":"<p>Encode an array of tuple <code>{lat:, lng:}</code> to a polyline string.</p>","abstract":false,"args":[{"name":"points","doc":null,"default_value":"","external_name":"points","restriction":"Array(LooseLocation)"},{"name":"precision","doc":null,"default_value":"5","external_name":"precision","restriction":"UInt8"}],"args_string":"(points : Array(LooseLocation), precision : UInt8 = <span class=\"n\">5</span>) : String","args_html":"(points : Array(<a href=\"Polylines/LooseLocation.html\">LooseLocation</a>), precision : UInt8 = <span class=\"n\">5</span>) : String","location":{"filename":"src/polylines.cr","line_number":72,"url":"https://github.com/BuonOmo/polylines.cr/blob/77041756da90efbd5aa615ff609990ad4be73432/src/polylines.cr#L72"},"def":{"name":"encode","args":[{"name":"points","doc":null,"default_value":"","external_name":"points","restriction":"Array(LooseLocation)"},{"name":"precision","doc":null,"default_value":"5","external_name":"precision","restriction":"UInt8"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"String","visibility":"Public","body":"estimated_polyline_size = (points.size * precision) * 2\nString.build(estimated_polyline_size) do |io|\n  precision = 10.0 ** precision\n  last_lat = last_lng = 0_i64\n  points.each do |point|\n    lat = ((lat(point)) * precision).round.to_i64\n    lng = ((lng(point)) * precision).round.to_i64\n    encode_number(lat - last_lat, io)\n    encode_number(lng - last_lng, io)\n    last_lat = lat\n    last_lng = lng\n  end\nend\n"}}],"macros":[],"types":[{"html_id":"polylines/Polylines/LatLngLocation","path":"Polylines/LatLngLocation.html","kind":"alias","full_name":"Polylines::LatLngLocation","name":"LatLngLocation","abstract":false,"superclass":null,"ancestors":[],"locations":[{"filename":"src/polylines.cr","line_number":27,"url":"https://github.com/BuonOmo/polylines.cr/blob/77041756da90efbd5aa615ff609990ad4be73432/src/polylines.cr#L27"}],"repository_name":"polylines","program":false,"enum":false,"alias":true,"aliased":"(Array(Float64) | Tuple(Float64, Float64))","aliased_html":"Array(Float64) | {Float64, Float64}","const":false,"constants":[],"included_modules":[],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":{"html_id":"polylines/Polylines","kind":"module","full_name":"Polylines","name":"Polylines"},"doc":"The first item must be the lat, and second must be lng.","summary":"<p>The first item must be the lat, and second must be lng.</p>","class_methods":[],"constructors":[],"instance_methods":[],"macros":[],"types":[]},{"html_id":"polylines/Polylines/Location","path":"Polylines/Location.html","kind":"alias","full_name":"Polylines::Location","name":"Location","abstract":false,"superclass":null,"ancestors":[],"locations":[{"filename":"src/polylines.cr","line_number":25,"url":"https://github.com/BuonOmo/polylines.cr/blob/77041756da90efbd5aa615ff609990ad4be73432/src/polylines.cr#L25"}],"repository_name":"polylines","program":false,"enum":false,"alias":true,"aliased":"NamedTuple(lat: Float64, lng: Float64)","aliased_html":"{lat: Float64, lng: Float64}","const":false,"constants":[],"included_modules":[],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":{"html_id":"polylines/Polylines","kind":"module","full_name":"Polylines","name":"Polylines"},"doc":"The default location that will be given by `Polylines.decode`.","summary":"<p>The default location that will be given by <code><a href=\"../Polylines.html#decode(polyline:String,precision:UInt8=5):Array(Location)-instance-method\">Polylines.decode</a></code>.</p>","class_methods":[],"constructors":[],"instance_methods":[],"macros":[],"types":[]},{"html_id":"polylines/Polylines/LooseLocation","path":"Polylines/LooseLocation.html","kind":"alias","full_name":"Polylines::LooseLocation","name":"LooseLocation","abstract":false,"superclass":null,"ancestors":[],"locations":[{"filename":"src/polylines.cr","line_number":29,"url":"https://github.com/BuonOmo/polylines.cr/blob/77041756da90efbd5aa615ff609990ad4be73432/src/polylines.cr#L29"}],"repository_name":"polylines","program":false,"enum":false,"alias":true,"aliased":"(Array(Float64) | NamedTuple(lat: Float64, lng: Float64) | Tuple(Float64, Float64))","aliased_html":"Array(Float64) | {lat: Float64, lng: Float64} | {Float64, Float64}","const":false,"constants":[],"included_modules":[],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":{"html_id":"polylines/Polylines","kind":"module","full_name":"Polylines","name":"Polylines"},"doc":"Allows more types to be passed to `Polylines.encode`.","summary":"<p>Allows more types to be passed to <code><a href=\"../Polylines.html#encode(points:Array(LooseLocation),precision:UInt8=5):String-instance-method\">Polylines.encode</a></code>.</p>","class_methods":[],"constructors":[],"instance_methods":[],"macros":[],"types":[]}]}]}})