# Payloads thoughts



Instead of
```json
"base_metadata": {
    "title": "Mercy Seat, The",
    "creator": "Cave, Nick",
    "date": 1998,
    "abstract": "Only the best freakin song ever.",
    "thumbnail": "SOME URL HERE"
},
"metadata": {
    "mods": {"url": "SOME URL HERE"}
},
"representations": {
...
```
I might go with
```json

"metadata": {
    "base": {
        "title": "Mercy Seat, The",
        "creator": "Cave, Nick",
        "date": 1998,
        "abstract": "Only the best freakin song ever.",
        "thumbnail": "SOME URL HERE"
    },  
        "mods": {"url": "SOME URL HERE"},
    },
"representations": {
...
```
That'd keep all the metadata together so I don't have to treat the `base` separately when I dig up the metadata to render: I can just loop through the `base` first, and and then follow the same loop-handling for everything else however the Renderer is set up. That also consolidates how Extractors handle the data, and how an Extractor could pick and choose.

What's "base", though? I would've said Dublin Core, until I saw "thumbnail" (I think we mentioned having the same 5 thumbnail urls, then also having a url of the image I can scale within CERES -- all IIIF, or am I misremembering?). Thumbnail feel more like representations than metadata to me.

Alternative for the order in the JSON: make everything an array. An array is by nature ordered, and if order doesn't matter, well, it doesn't matter that in both cases I loop through the array and Bob's your uncle. This Implies that when that the JSON is generated, that order data can be parsed around into a correctly ordered array on David's end.

I'd imagine that the METS behind the JSON would want to keep things like `TEI_Files` and `Indexed_TEI_Files` sharply distinct, as they are in `PY_payload.json`, for our internal organization and structures. For the API JSON response, it might be easier to work with to reunite them, if possible. So, `PMJ_payload.json` puts them in more of a hierarchy. `TEI_Files` and `Indexed_TEI_Files` get put together into one `TEI` key, with data about the indexed TEI more closely attached to source TEI:

```json
"TEI": [
    {
        "language": "en",
        "url": "SOME URL HERE",
        "fits": "SOME URL HERE",
        "indexed": {
            "language": "en",
            "url": "SOME URL HERE"
        }
    },
    {
        "language": "sp",
        "url": "SOME URL HERE",
        "fits": "SOME URL HERE",
        "indexed": {
            "language": "en",
            "url": "SOME URL HERE"
        }
    }
],

```





The IIIF handling seems like it could have some complications. But here, I'm working with the [simplest manifest](https://iiif.io/api/cookbook/recipe/0001-mvm-image/), which is basically 1-1 image to manifest. The structure of keys of `url`, `manifest` leaves open adding `annotation`, but again assumes 1-1 with image I _think_. Might need a deeper dive into it with others.

In an earlier example METS, we had put `@MIMETYPE` somewhere. It looks, though, like in most cases that type-hinting can come through with the JSON keys. However, it might be nice to carry that through explicitly as I've done in a couple places in `PMJ_payload.json`. 



